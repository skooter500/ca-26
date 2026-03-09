extends RigidBody2D

func _ready() -> void:
	scale = Vector2.ZERO
	var t = create_tween()
	t.tween_property(self, "scale", Vector2.ONE, 2)
	# t.tween_property(self, "position:x", 200, 2)
	t.set_ease(Tween.EASE_OUT)
	t.set_trans(Tween.TRANS_ELASTIC)
	pass
