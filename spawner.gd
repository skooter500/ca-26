extends Node2D

@export var block_scene:PackedScene


func _on_button_pressed() -> void:

	var block = block_scene.instantiate()
	block.get_node("ColorRect").color = Color.from_hsv(randf(), 1, 1, 0.8)
	add_child(block)	
	$"../AudioStreamPlayer".pitch_scale = randf_range(0.7, 1.4)
	$"../AudioStreamPlayer".play()
	pass # Replace with function body.
