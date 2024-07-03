extends Area2D

const LASER_DAMAGE = 5
const OUT_OF_BOUNDS_BUFFER = 500

@export var speed := 800
var screen_boundary_width
var screen_boundary_height

signal collision

func _ready():
	screen_boundary_width = get_viewport().get_visible_rect().size[0]
	screen_boundary_height = get_viewport().get_visible_rect().size[1]
	
	var tween = create_tween()
	tween.tween_property($Sprite2D, 'scale', Vector2(1,1), 0.8).from(Vector2(0,0))

func _process(delta):
	var angle = rotation
	position -= Vector2(sin(-angle-1.60), cos(-angle-1.60)) * speed * delta
	

	if position.x > screen_boundary_width + OUT_OF_BOUNDS_BUFFER or \
		position.x < 0 - OUT_OF_BOUNDS_BUFFER or \
		position.y > screen_boundary_height + OUT_OF_BOUNDS_BUFFER or \
		position.y < 0 - OUT_OF_BOUNDS_BUFFER:
		queue_free()
