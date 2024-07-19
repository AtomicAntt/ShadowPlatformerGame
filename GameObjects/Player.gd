extends CharacterBody2D

enum States {AIR, FLOOR, DEAD}
var state: States = States.AIR

const SPEED = 200.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float):
	move_and_slide()
	fall(delta)
	
	match state:
		States.AIR:
			get_horizontal_movement()
			if is_on_floor():
				state = States.FLOOR
		States.FLOOR:
			get_horizontal_movement()
			if Input.is_action_pressed("up"):
				velocity.y += JUMP_VELOCITY
				state = States.AIR
		States.DEAD:
			pass
	
func get_horizontal_movement() -> void:
	if Input.is_action_pressed("right"):
		velocity.x = lerp(velocity.x, SPEED, 0.2)
		$AnimatedSprite2D.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = lerp(velocity.x, -SPEED, 0.2)
		$AnimatedSprite2D.flip_h = true
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.4)

func fall(delta: float) -> void:
	velocity.y += gravity * delta
