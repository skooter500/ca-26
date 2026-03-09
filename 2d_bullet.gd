extends Area2D

var color 
var speed = 300

func _draw() -> void:
	draw_line(Vector2(0, -5), Vector2(0, 5), color, 5)
	
func _process(delta: float) -> void:
	queue_redraw()
	translate(- transform.y * speed * delta)
