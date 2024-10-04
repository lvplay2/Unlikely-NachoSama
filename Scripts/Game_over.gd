extends Node2D

onready var die = $Die

func _ready()->void :
	die.play()
	yield (get_tree().create_timer(3), "timeout")
	Global.level = 1
	
	get_tree().change_scene("res://Scenes/loading.tscn")
