extends RigidBody2D

var basketball_scene := preload("res://Assets/basketball.tscn")
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready():
	body_entered.connect(handle_collision)
	
func handle_collision(body):
	if is_queued_for_deletion():
		return
	if not body.is_in_group('base'):
		return
	if body == self:
		return
	
	print('it works')
	body.queue_free()
	queue_free()
	
	var ball = basketball_scene.instantiate()
	ball.global_position = (global_position + body.global_position) / 2
	get_parent().add_child.call_deferred(ball)
