extends Area2D

@export var speed := 800

func _ready():
	var tween = create_tween()
	tween.tween_property($Sprite2D, 'scale', Vector2(1,1), 0.8).from(Vector2(0,0))

func _process(delta):
	var angle = rotation
	position -= Vector2(sin(-angle-1.60), cos(-angle-1.60)) * speed * delta
