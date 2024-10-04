extends Node2D

const SAVE_DIR = "res://saves/"

var save_path = SAVE_DIR + "Save&&Load"


func save(idioma)->void :
	var data = {
		"idioma": idioma, 
	}
	var dir = Directory.new()
	if not dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
	var file = File.new()
	var error = file.open_encrypted_with_pass(save_path, File.WRITE, "Lë0nCí0KâkA16xD!")
	if error == OK:
		file.store_var(data)
		file.close()


func Load():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open_encrypted_with_pass(save_path, File.READ, "Lë0nCí0KâkA16xD!")
		if error == OK:
			var game_data = file.get_var()
			file.close()
			print(save_path)
			return game_data
	else :
		return {"idioma": "empty"}
