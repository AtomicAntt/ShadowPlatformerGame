extends PointLight2D

@export var NUM_RAYS = 160
@export var RAY_LENGTH = 200
@export var DEGREES: float = 360

var raycasts = []

func _process(delta: float) -> void:
	check_player(delta)

func _ready():
	for i in range(NUM_RAYS):
		var raycast = RayCast2D.new()
		raycast.target_position = Vector2(RAY_LENGTH, 0)
		raycast.rotation_degrees = i * (DEGREES / NUM_RAYS)
		add_child(raycast)
		raycasts.append(raycast)

func check_player(delta: float) -> void:
	for raycast in raycasts:
		if raycast.is_colliding():
			var collider = raycast.get_collider()
			
			# This is a "Attempt to call function 'is_in_group' in base 'null instance' on a null instance moment, thats why i added these 2 codes in front of me
			if !is_instance_valid(collider):
				return
			
			if collider.is_in_group("Player"):
				collider.hurt(delta * 100)
				return
