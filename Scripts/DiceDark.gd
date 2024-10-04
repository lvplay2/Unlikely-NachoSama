extends Node2D

var vel = Vector2.ZERO
var speed = 600
var rand_number = true
var set_value = true

onready var face = $Number


func _ready():
	randomize()


func _process(_delta):
	delete(Global.erase)
	if rand_number:
		face.animation = str(randi() % 6 + 1)
	elif set_value:
		get_parent().dice_dark_value(face.animation)
		set_value = false


func _on_Timer_timeout():
	rand_number = false


func delete(n):
	if n:
		call_deferred("queue_free")
