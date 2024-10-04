extends Node2D



const espanol = "español"
const english = "english"



var idioma = english



func _on_Espaol_pressed()->void :
	idioma = espanol
	Global.idioma = idioma
	continuar()


func _on_English_pressed()->void :
	idioma = english
	Global.idioma = idioma
	continuar()


func continuar()->void :
	save()
	Global.level = 1

	get_tree().change_scene("res://Scenes/loading.tscn")


func save()->void :
	SaveSystem.save(idioma)
