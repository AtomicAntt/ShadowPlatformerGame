extends CharacterBody2D

enum States {AIR, FLOOR, DEAD}
var state: States = States.AIR

const SPEED = 200.0
const JUMP_VELOCITY = -300.0

const MAX_HEALTH: float = 100
var health: float = 100

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta: float):
	check_light_sources(delta)

func _physics_process(delta: float):
	move_and_slide()
	fall(delta)
	#check_light_sources(delta) # Delta is passed because that is how much the player hurts/heals
	
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

func hurt(damage: float) -> void:
	health -= damage
	$HealthBar.value = health
	alter_transparency(health)

func check_light_sources(delta: float) -> void:
	var inLightSource: bool = false
	
	for light_source in get_tree().get_nodes_in_group("LightSource"):
		# I check if it is not in light source before hurting because only one light source hurts the player at a time.
		if light_source.sees_player() and not inLightSource:
			print("hurting now")
			hurt(delta * 100)
	
	# If no light sources are found, heal player by unhurting them:
	#if not inLightSource:
		#hurt(-delta * 100)
	

func alter_transparency(health: float) -> void:
	$AnimatedSprite2D.modulate.a = health / MAX_HEALTH
