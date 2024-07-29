extends Node2D

var raycasts = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for raycast in $PointLight2D.get_children():
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_player(delta)
