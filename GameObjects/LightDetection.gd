extends PointLight2D

const NUM_RAYS = 80
const RAY_LENGTH = 200

var raycasts = []

var onPlayer: bool = false

func _ready():
	for i in range(NUM_RAYS):
		var raycast = RayCast2D.new()
		raycast.target_position = Vector2(RAY_LENGTH, 0)
		raycast.rotation_degrees = i * (360 / NUM_RAYS)
		add_child(raycast)
		raycasts.append(raycast)

func _physics_process(delta):
	var seesPlayer: bool = false # This is a more temporary variable to see if any raycasts are on the player each frame
	
	for raycast in raycasts:
		if raycast.is_colliding():
			var collider = raycast.get_collider()
			if collider.is_in_group("Player"):
				seesPlayer = true
	
	# If none of the raycasts hit a player, we can determine that the light source is no longer on the player.
	
	if seesPlayer:
		onPlayer = true
	else:
		onPlayer = false
