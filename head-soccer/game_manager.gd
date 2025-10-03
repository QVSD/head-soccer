extends Node

var score_left: int = 0
var score_right: int = 0
@export var ball: RigidBody2D


func _ready():
	Global.goal_scored.connect(_on_goal_scored)

func _on_goal_scored(team_id: int):
	if team_id == 0:
		score_left += 1
	else:
		score_right += 1

	print("Scor: ", score_left, " - ", score_right)
	reset_ball()

func reset_ball():
	if ball:
		print("Stiu cplm sa zic")
		ball.position = Vector2(512, 300)
		ball.linear_velocity = Vector2.ZERO
		ball.angular_velocity = 0
	else :
		print("Nush cplm sa zic")
