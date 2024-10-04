extends Node2D

onready var numberA = $Number01
onready var numberB = $Number02
onready var numberC = $Number03
onready var blood = $Blood

var vel = Vector2.ZERO
var speed = 600
var parent_n = true


func _ready():
	randomize()
	blood.animation = str(randi() % 3 + 1)
	numberA.animation = str(randi() % 6 + 1)
	numberB.animation = str(randi() % 6 + 1)
	numberC.animation = str(randi() % 6 + 1)
	get_parent().set_values_dice(numberA.animation, numberB.animation, numberC.animation)


func _process(delta):
	delete(Global.erase)
	if position.y < 400:
		vel.y += 1
	else :
		vel.y = 0
	if vel.length() > 0:
		vel = vel.normalized() * speed * delta
	position += vel


func delete(n):
	if n:
		call_deferred("queue_free")
