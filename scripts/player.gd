extends CharacterBody2D

@export var speed := 4000
@export var rotation_speed = 5

var rotation_direction = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func get_input():
	rotation_direction = Input.get_axis("left", "right")
	velocity = -transform.y * Input.get_axis("back", "forward") * speed

func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()
