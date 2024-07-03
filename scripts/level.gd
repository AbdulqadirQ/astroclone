extends Node2D

var laser_scene: PackedScene = load("res://scenes/laser.tscn")


func _ready():
	pass # Replace with function body.


func _process(delta):
	pass

func _on_player_laser(pos, ship_rotation):
	var laser = laser_scene.instantiate()
	$Lasers.add_child(laser)
	laser.position = pos
	laser.rotation = ship_rotation - 1.6
