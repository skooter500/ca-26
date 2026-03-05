extends Node2D

var p = Vector2(50, 0)
var lerped_p = p

func _draw() -> void:
	draw_circle(p, 100, Color.REBECCA_PURPLE)
	p.y += randf_range(-20, 20)
	
	lerped_p.y = lerp(lerped_p.y, p.y, 0.1)
	lerped_p.x = 100
	draw_circle(lerped_p, 100, Color.AQUAMARINE)
	

func _process(delta: float) -> void:
	queue_redraw()
