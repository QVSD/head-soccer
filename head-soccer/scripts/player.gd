extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var action_left : String
@export var action_right : String
@export var action_jump : String

var kick_strength := 600.0
var velocity_influence := 0.5


func _physics_process(delta: float) -> void:
	if (velocity.x > 1 || velocity.x < -1):
		animated_sprite_2d.animation = "running"
	else:
		animated_sprite_2d.animation = "default"
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite_2d.animation = "jumping"

	# Handle jump.
	if Input.is_action_just_pressed(action_jump) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis(action_left, action_right)
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("node2d entered")
	if body.is_in_group("ball-example-1"):
		var ball := body as RigidBody2D

		# Compute direction
		var dir = (ball.global_position - global_position).normalized()

		# Base velocity kick
		var new_vel = dir * kick_strength

		# Add influence from player's velocity
		new_vel += velocity * velocity_influence

		# Directly set ball velocity (arcade style!)
		ball.linear_velocity = new_vel
		
	
	
