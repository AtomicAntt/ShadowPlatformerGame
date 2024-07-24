extends PointLight2D

const NUM_RAYS = 160
const RAY_LENGTH = 200

var raycasts = []

func _ready():
	for i in range(NUM_RAYS):
		var raycast = RayCast2D.new()
		raycast.target_position = Vector2(RAY_LENGTH, 0)
		raycast.rotation_degrees = i * (360 / NUM_RAYS)
		add_child(raycast)
		raycasts.append(raycast)

func sees_player() -> bool:
	for raycast in raycasts:
		if raycast.is_colliding():
			var collider = raycast.get_collider()
			if collider.is_in_group("Player"):
				return true
	return false
