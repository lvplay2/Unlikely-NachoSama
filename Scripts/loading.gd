extends Node2D



const text_pos = 1380
const text_ajuste = 80
const text_espanol = "Cargando ..."
const text_english = "Loading ..."



onready var texto = $Texto



func _ready()->void :
	OS.center_window()
	var game_data = SaveSystem.Load()
	if game_data["idioma"] != "empty":
		Global.idioma = game_data["idioma"]
	else :
		Global.level = 0
	
	if Global.idioma == "español":
		texto.rect_position.x = text_pos - text_ajuste
		texto.text = text_espanol
	else :
		texto.rect_position.x = text_pos
		texto.text = text_english
	
	yield (get_tree().create_timer(0.02), "timeout")
	
	if Global.level == 0:
		
		get_tree().change_scene("res://Scenes/Intro.tscn")
	elif Global.level == 1:
		
		get_tree().change_scene("res://Scenes/Menu.tscn")
	else :
	
		get_tree().change_scene("res://Scenes/Room.tscn")
