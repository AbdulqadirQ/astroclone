extends RigidBody2D

@export var meteor_mass_kg = 500000000
var ROTATION_TORQUE = 4500 * meteor_mass_kg
var SHIP_IMPULSE = 20 * meteor_mass_kg
const INERTIA = 0 # the higher this value, the more difficult it is for ship to turn
const GRAVITY = 0

var screen_size = null

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	var rng := RandomNumberGenerator.new()
	var width = get_viewport().get_visible_rect().size[0]
	var random_x = rng.randi_range(0, width)
	var random_y = rng.randi_range(-150, -50)
	position = Vector2(random_x, random_y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _integrate_forces(state):
	gravity_scale = GRAVITY
	screen_wrap()

func screen_wrap():
	position.x = wrapf(position.x, -150, screen_size.x+150)
	position.y = wrapf(position.y, -150, screen_size.y+150)
