extends KinematicBody

var velocity = Vector3()

var speed = 12
var spin = 0.1

func get_input():
	velocity.x = 0
	velocity.z = 0
	velocity.y = 0
	var real_speed = speed;
	if Input.is_key_pressed(KEY_SHIFT):
		real_speed *= 2;
	if Input.is_key_pressed(KEY_W):
		velocity += -transform.basis.z * real_speed
	if Input.is_key_pressed(KEY_S):
		velocity += transform.basis.z * real_speed
	if Input.is_key_pressed(KEY_D):
		velocity += transform.basis.x * real_speed
	if Input.is_key_pressed(KEY_A):
		velocity += -transform.basis.x * real_speed
	if Input.is_key_pressed(KEY_F):
		velocity += -transform.basis.y * real_speed * 1.5
	if Input.is_key_pressed(KEY_SPACE):
		velocity += transform.basis.y * real_speed * 1.5

func _process(delta):
	get_input();
	velocity = move_and_slide(velocity, Vector3.UP);
	

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if Input.is_mouse_button_pressed(BUTTON_RIGHT):
			if event.relative.x > 0:
				rotate_y(-lerp(0, spin, event.relative.x/10))
			elif event.relative.x < 0:
				rotate_y(-lerp(0, spin, event.relative.x/10))
