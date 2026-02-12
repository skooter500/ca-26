extends Area3D

@export var speed:float = 20
@export var explosion_scene:PackedScene

func _physics_process(delta: float) -> void:
	translate(Vector3.FORWARD * speed * delta)


func _on_body_entered(body: Node3D) -> void:
	body.queue_free()
	self.queue_free()
	var explosion = explosion_scene.instantiate()
	get_tree().root.add_child(explosion)
	var col = body.get_node("MeshInstance3D").get_surface_override_material(0).albedo_color	
	explosion.emitting = true
	explosion.get_material_override().albedo_color = col
	explosion.global_position = self.global_position
	print("I hit something!!")
	pass # Replace with function body.
