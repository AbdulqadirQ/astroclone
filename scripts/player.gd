extends RigidBody2D

var SHIP_MASS_KG = 5
var ROTATION_TORQUE = 4500 * SHIP_MASS_KG
var SHIP_IMPULSE = 20 * SHIP_MASS_KG
const INERTIA = 0 # the higher this value, the more difficult it is for ship to turn
const GRAVITY = 0

var screen_size = null

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	position = Vector2(960,540)

func _integrate_forces(_state):
	gravity_scale = GRAVITY
	mass = SHIP_MASS_KG
	if Input.is_action_pressed("forward"):
		var angle = rotation
		apply_central_impulse(Vector2(sin(-angle), cos(angle)) * -SHIP_IMPULSE)

	set_inertia(INERTIA)
	if Input.is_action_pressed("right"):
		apply_torque(ROTATION_TORQUE)
	if Input.is_action_pressed("left"):
		apply_torque(-ROTATION_TORQUE)
	screen_wrap()

func screen_wrap():
	position.x = wrapf(position.x, -50, screen_size.x+50)
	position.y = wrapf(position.y, -50, screen_size.y+50)

func _on_body_entered(body):
	print("Collision")
