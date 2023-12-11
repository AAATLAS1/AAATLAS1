extends CharacterBody3D

var gravity = 15
var speed = 5.5
var jump_speed = 7
var mouse_sensitivity = 0.002
var run_speed = 9.5

func _input(event):
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Camera3D.rotate_x(-event.relative.y * mouse_sensitivity)
		$Camera3D.rotation.x = clamp($Camera3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))

func _physics_process(delta):
	velocity.y += -gravity * delta
	var input = Input.get_vector("pressed a", "pressed d", "pressed w", "pressed s")
	var movement_dir = transform.basis * Vector3(input.x, 0, input.y)
	velocity.x = movement_dir.x * speed
	velocity.z = movement_dir.z * speed
	
	if  is_on_floor() and Input.is_action_pressed("pressed space"):
		velocity.y = jump_speed
		
	if Input.is_action_pressed('pressed w бег'):
		velocity.x = movement_dir.x * run_speed
		velocity.z = movement_dir.z * run_speed
		
	move_and_slide()
