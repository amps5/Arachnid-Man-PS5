extends KinematicBody2D

const MOVE_SPEED = 500
const JUMP_FORCE = 1000
const GRAVITY = 50
const MAX_FALL_SPEED = 1000

var y_velo = 0
var grounded 

#gives the player 0.1 seconds after leaving the ground where they can still jump
func coyote_time():
	yield(get_tree().create_timer(.1), "timeout")
	grounded = false

func _physics_process(delta):
	var move_dir = 0
	#this moves the character you fucking dunce
	if Input.is_action_pressed("ui_right"):
		move_dir += 1
	if Input.is_action_pressed("ui_left"):
		move_dir -= 1
	move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velo), Vector2(0, -1))
	
	#checks if the player is on the floor
	if is_on_floor():
		grounded = true
	else:
		coyote_time()
	
	#wall and cieling stick
	if not is_on_ceiling() and not is_on_wall():
		y_velo += GRAVITY
	#jump
	if grounded and Input.is_action_just_pressed("ui_up"):
		y_velo = -JUMP_FORCE
	#wall climb
	if is_on_wall() and Input.is_action_pressed("ui_up"):
		if y_velo > 300:
			y_velo = 200
		else:
			y_velo -= 10
	#i dont remeber what this does
	if grounded and y_velo >= 5:
		y_velo = 5
	if y_velo > MAX_FALL_SPEED:
		y_velo = MAX_FALL_SPEED
