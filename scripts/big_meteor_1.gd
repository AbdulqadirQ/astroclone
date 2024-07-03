extends StaticBody2D

var explosion_scene: PackedScene = load("res://scenes/explosion.tscn")

const SIZE_DAMAGE_MODIFIER := 3

var direction_x: float
var direction_y: float
var health := 25
var rotation_speed: int
var screen_size: Vector2
var speed: int

func _ready():
	screen_size = get_viewport_rect().size
	var rng := RandomNumberGenerator.new()
	var width = get_viewport().get_visible_rect().size[0]
	var random_x = rng.randi_range(0, width)
	var random_y = rng.randi_range(-150, -50)
	position = Vector2(random_x, random_y)
	
	speed = rng.randi_range(300, 500)
	direction_x = rng.randf_range(-1, 1)
	direction_y = rng.randf_range(0.1, 1)
	rotation_speed = rng.randi_range(40, 100)


func _process(delta):
	position += Vector2(direction_x, direction_y) * speed * delta
	rotation_degrees += rotation_speed * delta
	screen_wrap()
	if(health <= 0):
		print(health)
		# get rid of meteor
		queue_free()

func screen_wrap():
	position.x = wrapf(position.x, -150, screen_size.x+150)
	position.y = wrapf(position.y, -150, screen_size.y+150)


func _on_area_2d_area_entered(area):
	if(area.is_in_group("lasers")):
		health -= area.LASER_DAMAGE
		# get rid of laser
		area.queue_free()
		print(health)
		
		var explosion = explosion_scene.instantiate()
		$Explosions.add_child(explosion)
		await get_tree().create_timer(0.1).timeout
		explosion.queue_free()
