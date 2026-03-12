extends CharacterBody3D

func _ready() -> void:
	var target = self.rotation
	target.x += target.x + PI * 0.5
	get_tree().create_tween().tween_property(self, "rotation", target, 2).set_trans(Tween.TRANS_CUBIC)
