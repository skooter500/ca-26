extends Sprite2D

@export var speed:float = 50

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass
	
func  _physics_process(delta: float) -> void:
	# position.x += delta * 5
	# rotation += 
	# translate(Vector2.DOWN * delta * speed)
	# translate(transform.x * delta * speed)
	# $"../Label".text = "transform.x" + str(transform.x)
	# transform.y = transform.forward
	# transform.x
	move_ad
	
	
	
