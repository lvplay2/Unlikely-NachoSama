extends Node2D

onready var number = $Number

var vel = Vector2.ZERO
var speed = 600
var rand_number = true
var set_value = true


func _ready():
	randomize()


func _process(_delta):
	delete(Global.erase or Global.dice_erase)
	if rand_number:
		number.animation = str(randi() % 6 + 1)
	elif set_value:
		get_parent().dice_value(number.animation)
		set_value = false


func _on_Timer_timeout():
	rand_number = false


func delete(n):
	if n:
		call_deferred("queue_free")
