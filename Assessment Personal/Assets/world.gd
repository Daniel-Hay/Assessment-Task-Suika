extends Node2D
@onready var left_marker: Marker2D = $Marker2D
@onready var right_marker: Marker2D = $Marker2D2

# Preloads all the different balls used 
var pingpong_scene := preload("res://Assets/pingpong.tscn")
var tennis_scene := preload("res://Assets/tennis.tscn")
var baseball_scene := preload("res://Assets/baseball.tscn")
var basketball_scene := preload("res://Assets/basketball.tscn")
var current_ball

func _ready():
	current_ball = create_ball((left_marker.global_position + right_marker.global_position) / 2)

# Checks to see if space is pressed, if so then call drop function
func _physics_process(_delta):
	if Input.is_action_just_pressed("drop"):
		drop_ball()
		
	if current_ball.gravity_scale == 0:
		var ball_x = clamp(
			get_global_mouse_position().x,
			left_marker.global_position.x,
			right_marker.global_position.x
		)
		current_ball.global_position.x = ball_x
	
	
func create_ball(position):
	randomize()
	var balls = [pingpong_scene, tennis_scene]
	var kinds = balls[randi()% 2]
	var ball = kinds.instantiate()
	ball.gravity_scale = 0
	ball.global_position = position
	add_child(ball)
	return ball
	
func drop_ball():
	current_ball.gravity_scale = 1
	current_ball = create_ball((left_marker.global_position + right_marker.global_position) / 2)

