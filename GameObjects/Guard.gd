extends CharacterBody2D

var direction: float = 1
var speed: float = 50

func _physics_process(delta):
	velocity.x = direction * speed
	move_and_slide()
	
	if not $GroundCheck.is_colliding():
		$Sprite2D.flip_h = !$Sprite2D.flip_h
		direction *= -1
		$GroundCheck.position.x = 2 * direction # Basically x is -2 (more left to the guard) if facing left so the guard doesnt fast spin
		$Flashlight.flip()
