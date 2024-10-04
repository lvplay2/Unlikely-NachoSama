extends Node2D

onready var face = $Face
onready var face2 = $Face2
onready var face3 = $Face3
onready var face4 = $Face4
onready var face5 = $DeadFace
onready var face6 = $Face5
onready var arm = $Arm
onready var arm2 = $Arm2
onready var animation = $AnimationPlayer
onready var liquid = $Liquid

var yes = true

func _ready():
	animation.current_animation = "Move"

func _process(_delta):
	if Global.end:
		face.visible = false
		if yes:
			face6.visible = true
		Global.insane = true
		animation.current_animation = "Dead"
		get_parent().ahia(true)
		yield (get_tree().create_timer(1), "timeout")
		get_parent().ahia(true)
		yield (get_tree().create_timer(1), "timeout")
		get_parent().ahia(true)
		yield (get_tree().create_timer(1), "timeout")
		get_parent().ahia(true)
		yield (get_tree().create_timer(1), "timeout")
		get_parent().ahia(true)
		yield (get_tree().create_timer(1), "timeout")
		get_parent().ahia(false)
		yield (get_tree().create_timer(0.5), "timeout")
		animation.stop()
		face5.position = Vector2.ZERO
		face5.rotation = 0
		face5.scale = Vector2(1, 1)
		if yes:
			yes = false
			face6.visible = false
			face.visible = false
			face5.visible = true
			yield (get_tree().create_timer(2), "timeout")
			face5.playing = true
			liquid.play()
		Global.end = false
		Global.insane = false


func show_animation(n):
	if n == 0:
		animation.current_animation = "Move"
		if Global.text < 13 or (Global.text >= 14 and not Global.end):
			face.visible = true
			face3.visible = false
		if Global.text != 13:
			face2.visible = false
			face4.visible = false
			arm.visible = true
			arm2.visible = false
	elif n == 1:
		animation.current_animation = "HAHA"
	elif n == 2:
		face.visible = false
		face2.visible = true
	elif n == 3:
		face.visible = false
		face3.visible = true
	elif n == 4:
		animation.current_animation = "Ok"
	elif n == 5:
		face.visible = false
		face4.visible = true
		arm.visible = false
		arm2.visible = true
		animation.current_animation = "Talk"
	elif n == 6:
		animation.current_animation = "Talk"
