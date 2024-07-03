extends Node2D

var meteor_scene: PackedScene = load("res://scenes/big_meteor_1.tscn")
var laser_scene: PackedScene = load("res://scenes/laser.tscn")


func _ready():
	var meteor = meteor_scene.instantiate()
	$Meteors.add_child(meteor)

func _process(_delta):
	pass

func _on_player_laser(pos, ship_rotation):
	var laser = laser_scene.instantiate()
	$Lasers.add_child(laser)
	laser.position = pos
	laser.rotation = ship_rotation - 1.6
