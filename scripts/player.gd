extends RigidBody2D

@export var ship_impulse := 5
@export var rotation_speed = 500

const INERTIA = 0 # the higher this value, the more difficult it is for ship to turn
const GRAVITY = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _integrate_forces(state):
	gravity_scale = GRAVITY
	if Input.is_action_pressed("forward"):
		var angle = $".".rotation
		print(angle)
		apply_central_impulse(Vector2(sin(-angle), cos(angle)) * -ship_impulse)

	set_inertia(INERTIA)
	if Input.is_action_pressed("right"):
		apply_torque(rotation_speed)
	if Input.is_action_pressed("left"):
		apply_torque(-rotation_speed)
