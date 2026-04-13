extends CharacterBody3D

var SPEED = 5.0
const JUMP_VELOCITY = 4.5
const WALK_SPEED = 5.0
const SPRINT_SPEED = 15.0

var input_dir: Vector2
var direction: Vector3

func _input(event: InputEvent) -> void:
	input_dir = Input.get_vector("left", "right", "forward", "back")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("sprint") and is_on_floor():
		SPEED = SPRINT_SPEED
	else:
		SPEED = WALK_SPEED

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
