extends RigidBody2D

var baseball_scene := preload("res://Assets/baseball.tscn")
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready():
	body_entered.connect(handle_collision)
	
func handle_collision(body):
	if is_queued_for_deletion():
		return
	if not body.is_in_group('tennis'):
		return
	if body == self:
		return
	
	print('it works')
	body.queue_free()
	queue_free()
	
	var ball = baseball_scene.instantiate()
	
	ball.global_position = (global_position + body.global_position) / 2
	get_parent().add_child.call_deferred(ball)

func disable_physics():
	gravity_scale = 0
	collision_layer = 0
	collision_mask = 0
	
func enable_physics():
	gravity_scale = 1
	collision_layer = 1
	collision_mask = 1

