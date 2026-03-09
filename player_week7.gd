extends CharacterBody2D

@export var speed:float = 100
@export var bullet_scene:PackedScene

func _ready() -> void:
	scale = Vector2.ZERO
	var t = create_tween().tween_property(self, "scale", Vector2.ONE, 2)
	t.set_ease(Tween.EASE_OUT)
	t.set_trans(Tween.TRANS_ELASTIC)
	$Timer.timeout.connect(fire_again)

	pass
	
var r = 50
	
func _draw() -> void:
	draw_line(Vector2(-r, + r), Vector2(0, -r), Color.AQUAMARINE, 5)
	draw_line(Vector2(0, -r), Vector2(+r, +r), Color.AQUAMARINE, 5)
	draw_line(Vector2(+r, +r), Vector2(0, 0), Color.AQUAMARINE, 5)
	draw_line(Vector2(0, 0), Vector2(-r, +r), Color.AQUAMARINE, 5)

	pass

var can_fire = true	

func fire_again():
	can_fire = true

func _process(delta: float) -> void:
	if Input.is_action_pressed("fire") and can_fire:
		var b = bullet_scene.instantiate()
		b.rotation = rotation
		b.color = Color.AQUAMARINE
		get_tree().root.add_child(b)
		b.global_position = $bullet_spawn.global_position
		can_fire = false
		$Timer.start()
	
func _physics_process(delta: float) -> void:
	var f = Input.get_axis("backward", "forward")
	velocity = lerp(velocity, - transform.y * f * speed, delta)
	
	var r = Input.get_axis("left", "right")
	rotate(r * delta)
	move_and_slide()
