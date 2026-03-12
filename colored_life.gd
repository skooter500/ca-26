extends Node2D

var board = []
var next = []

var size = 200
var row = 0
var col = 0
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and event.button_mask & MOUSE_BUTTON_MASK_LEFT:
		var pos = event.position
		row = round(pos.y / float(cell_size))
		col = round(pos.x / float(cell_size))
		print(str(row) + "\t" + str(col))
		board[row][col] = randf()		
	

func create_board():
	for r in range(size):
		var row = []
		var row1 = []
		for c in range(size):
			row.append(0.0)
			row1.append(0.0)
		board.append(row)
		next.append(row1)
		
func print_board():
	for r in range(size):
		var row_string = ""
		for c in range(size):
			if board[r][c]:
				row_string += "1"
			else:
				row_string += "0"
		print(row_string)
		
func cross():
	var half = size / 2
	for i in size:
		board[half][i] = randf()
		board[i][half] = randf()
	
var screen_size
var cell_size
		
func _ready() -> void:
	create_board()
	# print_board()
	# randomize_board()
	# cross()
	print(count_neighbours(1,1))
	
	screen_size = get_viewport_rect().size
	cell_size = screen_size.x / float(size)
	
	pass
	
func randomize_board():
	for r in range(size):
		for c in range(size):
			var dice = randf()
			if dice > 0.5:
				board[r][c] = randf()
			else:
				board[r][c] = 0
	pass

func draw_board():
	
	for r in range(size):
		for c in range(size):
			var x = c * cell_size
			var y = r * cell_size
			if board[r][c]:
				draw_rect(Rect2(x, y, cell_size, cell_size), Color.from_hsv(board[r][c], 1,1), true)
	pass
	
func count_neighbours(row, col):
	var count = 0
	
	if row > 0 and col > 0 and board[row - 1][col - 1]:
		count += 1
	if row > 0 and board[row - 1][col]:
		count += 1
	if row > 0 and col < (size - 1) and board[row -1][col + 1]:
		count += 1
	if col > 0 and board[row][col -1]:
		count += 1
	if col < size - 1 and board[row][col + 1]:
		count += 1		
	if col > 0 and row < size -1 and board[row +1][col -1]:
		count += 1
	if row < size -1 and board[row + 1][col]:
		count += 1
	if row < size - 1 and col < size - 1 and board[row + 1][col + 1]:
		count += 1 
	return count
	
func average_hue(hues: Array) -> float:
	var sin_sum = 0.0
	var cos_sum = 0.0
	for h in hues:
		sin_sum += sin(h * TAU)
		cos_sum += cos(h * TAU)
	return fmod(atan2(sin_sum, cos_sum) / TAU + 1.0, 1.0)
	
func average_around(row, col):
	var hues = []
	
	if row > 0 and col > 0 and board[row - 1][col - 1]:
		hues.append(board[row - 1][col - 1])
	if row > 0 and board[row - 1][col]:
		hues.append(board[row - 1][col])
	if row > 0 and col < (size - 1) and board[row -1][col + 1]:
		hues.append(board[row -1][col + 1])
	if col > 0 and board[row][col -1]:
		hues.append(board[row][col -1])
	if col < size - 1 and board[row][col + 1]:
		hues.append(board[row][col + 1])
	if col > 0 and row < size -1 and board[row +1][col -1]:
		hues.append(board[row +1][col -1])
	if row < size -1 and board[row + 1][col]:
		hues.append(board[row + 1][col])
	if row < size - 1 and col < size - 1 and board[row + 1][col + 1]:
		hues.append(board[row + 1][col + 1])
	return average_hue(hues)
		
func update_board():
	for r in range(size):
		for c in range(size):
			var count = count_neighbours(r, c)
			if board[r][c]:
				if count == 2 or count == 3:
					next[r][c] = board[r][c]
				else:
					next[r][c] = 0
			else:
				if count == 3:
					next[r][c] = average_around(r,c)
				else:
					next[r][c] = 0
	var temp = board
	board = next
	next = temp
	pass

	
func _draw() -> void:
	# draw_line(Vector2(10, 10), Vector2(200, 200), Color.WHITE, 5)
	# draw_rect(Rect2(10, 10, 100, 50), Color.BLUE_VIOLET, true, 5)
	draw_board()
	pass
	
func _process(delta: float) -> void:	
	
	queue_redraw()
	if Engine.get_frames_drawn() % 10 == 0:
		update_board()
	
