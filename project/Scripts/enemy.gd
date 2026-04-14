class_name Enemy
extends CharacterBody3D

#region References
@onready var nav_agent = $NavigationAgent3D
@export var player: Player
#endregion

var health: float
const MAX_HEALTH: float = 20

const GRAVITY = 150
var speed: float = 2

func _ready() -> void:
	health = MAX_HEALTH
	
func _physics_process(delta: float) -> void:
	assert(player, "Player not set in inpector")
	nav_agent.target_position = player.global_position
	#print(nav_agent.target_position)
	
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	#print(next_location, " ", current_location)
	var new_velocity = (next_location - current_location).normalized() * speed
	
	velocity = new_velocity * speed
	
	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	
	move_and_slide()
