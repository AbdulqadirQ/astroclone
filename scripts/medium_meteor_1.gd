class_name MediumMeteor
extends StaticBody2D

var explosion_scene: PackedScene = load("res://scenes/explosion.tscn")

const medium_meteor_scene: PackedScene = preload("res://scenes/medium_meteor_1.tscn")
const SIZE_DAMAGE_MODIFIER := 2

var direction_x: float
var direction_y: float
var health := 10
var rotation_speed: int
var screen_size: Vector2
var spawn_position: Vector2
var spawn_direction_x: float
var spawn_direction_y: float
var speed: int

signal destroyed

static func new_meteor(spawn_position: Vector2, spawn_direction_x: float, spawn_direction_y: float) -> MediumMeteor:
	var new_meteor = medium_meteor_scene.instantiate()
	new_meteor.spawn_position = spawn_position
	new_meteor.spawn_direction_x = spawn_direction_x
	new_meteor.spawn_direction_y = spawn_direction_y
	return new_meteor

func _ready():
	screen_size = get_viewport_rect().size
	position = spawn_position
	
	var rng := RandomNumberGenerator.new()
	speed = rng.randi_range(300, 500)
	rotation_speed = rng.randi_range(40, 100)


func _process(delta):
	position += Vector2(spawn_direction_x, spawn_direction_y) * speed * delta
	rotation_degrees += rotation_speed * delta
	screen_wrap()

func screen_wrap():
	position.x = wrapf(position.x, -150, screen_size.x+150)
	position.y = wrapf(position.y, -150, screen_size.y+150)

func _on_area_2d_area_entered(area):
	if(area.is_in_group("lasers")):
		health -= area.LASER_DAMAGE
		print("Meteor health: ", health)
		var explosion = explosion_scene.instantiate()
		explosion.position = Vector2(0,0)
		$Explosions.add_child(explosion)
		await get_tree().create_timer(0.2).timeout
		# get rid of laser
		area.queue_free()
		# get rid of explosion
		explosion.queue_free()
		if(health <= 0):
			destroyed.emit()
			# get rid of meteor
			queue_free()
