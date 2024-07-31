extends CharacterBody2D

var direction: float = 1
@export var speed: float = 50

func _physics_process(delta):
	velocity.x = direction * speed
	move_and_slide()
	
	if not $GroundCheck.is_colliding() or is_on_wall():
		# all the complicated steps to flip all parts of this guy
		$Sprite2D.flip_h = !$Sprite2D.flip_h
		direction *= -1
		$GroundCheck.position.x = 2 * direction # Basically x is -2 (more left to the guard) if facing left so the guard doesnt fast spin
		$Flashlight.flip()
		$Flashlight.position.x *= -1
		$CollisionShape2D.position.x *= -1
