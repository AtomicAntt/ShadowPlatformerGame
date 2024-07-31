class_name Player
extends CharacterBody2D


enum States {AIR, FLOOR, DEAD, DISABLED}
var state: States = States.AIR

enum EntityState {HUMAN, SHADOW}
@export var entityState: EntityState = EntityState.SHADOW

@export var SPEED = 200.0
const JUMP_VELOCITY = -300.0

const MAX_HEALTH: float = 100
var health: float = 100

# How the system works:
# If heal_progress is at HEAL_CRITERIA, it will start healing the player
# heal_progress is reset every time you get hurt (not negatively hurt, which will be healing)
const HEAL_CRITERIA: float = 0.2
var heal_progress: float = 0.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float):
	move_and_slide()
	fall(delta)
	#check_light_sources(delta) # Delta is passed because that is how much the player hurts.
	heal_if_criteria_met(delta) # Delta is passed for two reasons: 
	# 1. Increment heal progress to check if criteria is met.
	# 2. It is how much the player heals.
	
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
			velocity.x = lerp(velocity.x, 0.0, 0.4)
		States.DISABLED:
			velocity.x = lerp(velocity.x, 0.0, 0.4)

func disable_movement() -> void:
	state = States.DISABLED
	# Added this because player was stuck on walk animation
	if entityState == EntityState.HUMAN:
		$AnimatedSprite2D.play("HumanIdle")
	else:
		$AnimatedSprite2D.play("Idle")

func enable_movement() -> void:
	state = States.AIR

func get_horizontal_movement() -> void:
	var entity: String = ""
	if entityState == EntityState.HUMAN:
			entity = entity + "Human"
	
	if Input.is_action_pressed("right"):
		velocity.x = lerp(velocity.x, SPEED, 0.2)
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play(entity+"Walk")
	elif Input.is_action_pressed("left"):
		velocity.x = lerp(velocity.x, -SPEED, 0.2)
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play(entity+"Walk")
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.4)
		$AnimatedSprite2D.play(entity+"Idle")

func fall(delta: float) -> void:
	velocity.y += gravity * delta

func hurt(damage: float) -> void:
	health -= damage
	clampf(health, 0.0, MAX_HEALTH)
	
	if health <= 0:
		state = States.DEAD
		var main = get_tree().get_nodes_in_group("main")[0]
		main.game_over()
	
	$HealthBar.value = health
	alter_transparency(health)
	
	if damage > 0: # If it heals instead of doing damage (negative number)
		heal_progress = 0.0 # Reset progress, now the player must wait HEAL CRITERIA seconds to heal again.

func heal_if_criteria_met(delta: float) -> void:
	heal_progress += delta
	#print(heal_progress)
	if heal_progress >= HEAL_CRITERIA and health < MAX_HEALTH:
		hurt(-delta * 100)

func alter_transparency(health: float) -> void:
	$AnimatedSprite2D.modulate.a = health / MAX_HEALTH
	
	if health < MAX_HEALTH:
		var tween = get_tree().create_tween()
		tween.tween_property($HealthBar, "modulate:a", 1, 0.2)
	else:
		var tween = get_tree().create_tween()
		tween.tween_property($HealthBar, "modulate:a", 0, 0.2)

func is_human() -> bool:
	if entityState == EntityState.HUMAN:
		return true
	return false

func transform_to_shadow() -> void:
	entityState = EntityState.SHADOW
	$AnimatedSprite2D.play("Idle")

func transform_to_human() -> void:
	entityState = EntityState.HUMAN
	$AnimatedSprite2D.play("HumanIdle")
