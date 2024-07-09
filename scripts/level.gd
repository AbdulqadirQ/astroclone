extends Node2D

var big_meteor_scene: PackedScene = load("res://scenes/big_meteor_1.tscn")
var laser_scene: PackedScene = load("res://scenes/laser.tscn")
var medium_meteor_scene: PackedScene = load("res://scenes/medium_meteor_1.tscn")

func _ready():
	var meteor = big_meteor_scene.instantiate()
	meteor.destroyed.connect(_on_big_meteor_destroyed)
	$Meteors.add_child(meteor)


func _process(_delta):
	pass

func _on_player_laser(pos, ship_rotation):
	var laser = laser_scene.instantiate()
	$Lasers.add_child(laser)
	laser.position = pos
	laser.rotation = ship_rotation - 1.6


func _on_big_meteor_destroyed(destroyed_position, destroyed_direction_x, destroyed_direction_y):
	var medium_meteor_1 = MediumMeteor.new_meteor(destroyed_position, destroyed_direction_x, destroyed_direction_y)
	var medium_meteor_2 = MediumMeteor.new_meteor(destroyed_position, -destroyed_direction_x, -destroyed_direction_y)
	$Meteors.add_child(medium_meteor_1)
	$Meteors.add_child(medium_meteor_2)
