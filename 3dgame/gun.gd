extends CSGBox3D

@export var projectile_scene:PackedScene

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fire"):
		var p = projectile_scene.instantiate()
		get_tree().root.add_child(p)
		$AudioStreamPlayer3D.pitch_scale = randf_range(0.8, 1.2)
		$AudioStreamPlayer3D.play()
		
		p.global_position = $bullet_spawn.global_position
		p.global_rotation = $bullet_spawn.global_rotation
