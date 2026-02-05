extends Area3D


func _on_body_entered(body):
	if body.is_in_group("player"):		
		print("Its a player")
		$AudioStreamPlayer3D.play()
		self.queue_free()
	pass # Replace with function body.
