extends Node2D

var board = []
var next = []

var size = 200

func create_board():
	for r in range(size):
		var row = []
		var row1 = []
		for c in range(size):
			row.append(false)
			row1.append(false)
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
		board[half][i] = true
		board[i][half] = true
		
func _ready() -> void:
	create_board()
	# print_board()
	# randomize_board()
	cross()
	print(count_neighbours(1,1))
	pass
	
func randomize_board():
	for r in range(size):
		for c in range(size):
			var dice = randf()
			if dice > 0.5:
				board[r][c] = true
			else:
				board[r][c] = false
	pass

func draw_board():
	var screen_size = get_viewport_rect().size
	var cell_size = screen_size.x / float(size)
	for r in range(size):
		for c in range(size):
			var x = c * cell_size
			var y = r * cell_size
			if board[r][c]:
				draw_rect(Rect2(x, y, cell_size, cell_size), Color.LIGHT_BLUE, true)
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
		
func update_board():
	for r in range(size):
		for c in range(size):
			var count = count_neighbours(r, c)
			if board[r][c]:
				if count == 2 or count == 3:
					next[r][c] = true
				else:
					next[r][c] = false
			else:
				if count == 3:
					next[r][c] = true
				else:
					next[r][c] = false
	var temp = board
	board = next
	next = temp
	pass

	
func _draw() -> void:
	# draw_line(Vector2(10, 10), Vector2(200, 200), Color.WHITE, 5)
	# draw_rect(Rect2(10, 10, 100, 50), Color.BLUE_VIOLET, true, 5)
	draw_board()
	update_board()
	pass
	
func _process(delta: float) -> void:
	
	queue_redraw()
