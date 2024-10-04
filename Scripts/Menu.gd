extends Node2D



var set_time = rand_range(0.5, 2)
var can_light = true

onready var light = $Light2D
onready var light_timer = $Timer
onready var light_out = $Timer2
onready var electric = $Electric
onready var texto = $Text / Points



func _ready()->void :
	Global.iniciar()
	if Global.idioma == "español":
		texto.rect_position.x -= 100
		if OS.get_name() == "Android":
			texto.text = "Toca para empezar"
		else :
			texto.text = "Click para empezar"
	else :
		texto.rect_position.x = 601
		if OS.get_name() == "Android":
			texto.text = "Touch to start"
		else :
			texto.text = "Click to start"
	OS.center_window()
	randomize()


func _process(_delta)->void :
	light_room()
	if Input.is_mouse_button_pressed(1):
		Global.level = 2

		get_tree().change_scene("res://Scenes/loading.tscn")


func light_room()->void :
	if not light.enabled and can_light:
		set_time = rand_range(0.5, 1)
		light_out.wait_time = set_time
		light_out.start()
		can_light = false


func _on_Timer_timeout()->void :
	light.enabled = false
	electric.playing = true
	can_light = true


func _on_Timer2_timeout()->void :
	set_time = rand_range(0.5, 2)
	light_timer.wait_time = set_time
	light_timer.start()
	light.enabled = true
	electric.playing = true
