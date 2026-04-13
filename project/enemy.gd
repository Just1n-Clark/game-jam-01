class_name Enemy
extends CharacterBody3D

#region References
@onready var nav_agent = $NavigationAgent3D
#endregion

var health: float
const MAX_HEALTH: float = 20

var speed: float = 3
var direction: Vector3

func _ready() -> void:
	health = MAX_HEALTH
	
func _physics_process(delta: float) -> void:
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * speed
	
	velocity = new_velocity + direction * speed
	
	if not is_on_floor():
		velocity.y -= 300 * delta
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var mouse_pos_2d = get_viewport().get_mouse_position()
		var camera = get_viewport().get_camera_3d()
		
		var mouse_pos_3d: Vector3 = camera.project_position(mouse_pos_2d, 0)
		
		nav_agent.target_position = mouse_pos_3d
