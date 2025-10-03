extends Node2D

@export var team_id: int = 0  # 0 = left, 1 = right
@export var is_right: bool = false

func _ready() -> void:
	$Area2D.body_entered.connect(_on_body_entered)
	if is_right:
		scale.x = -1
		position.x += 100

func _on_body_entered(body: Node) -> void:
	print("A intrat:", body.name, " groups:", body.get_groups())
	if body.is_in_group("ball"):  # check if its a Ball type
		print(" Gol pentru echipa " + str(team_id))
		# Signal towards the GameManager
		Global.emit_signal("goal_scored", team_id)


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
