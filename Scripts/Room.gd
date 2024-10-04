extends Node2D

const card_show = preload("res://Scenes/Cards.tscn")
const dice_show = preload("res://Scenes/Dice.tscn")
const dice_dark_show = preload("res://Scenes/DiceDark.tscn")

onready var light = $Light2D
onready var light_timer = $Timer
onready var light_out = $Timer2
onready var electric = $Electric
onready var card = $Card
onready var card_button = $Cards
onready var dice_button = $Dice
onready var dice_dark_button = $DiceDark
onready var dices = $Dices
onready var dicedark = $DiceDarkSound
onready var text_points = $CanvasLayer / Text / Points
onready var text_plus = $CanvasLayer / Text / Plus
onready var text_plays = $CanvasLayer / Text / Plays
onready var clown = $Clown
onready var dialog = $CanvasLayer / Text / Panel
onready var honk = $Honk
onready var voice = $Voice
onready var dark_voice = $Dark_voice
onready var really_dark_voice = $Really_dark_voice
onready var laugh = $Laugh
onready var honk_nose = $Clown / Nose
onready var bulb = $Bulb
onready var reroll_text = $CanvasLayer / Text / Rerolls
onready var reroll_sprite = $CanvasLayer / Text / Reroll
onready var yes_button = $CanvasLayer / Text / Panel / Yes
onready var no_button = $CanvasLayer / Text / Panel / No
onready var skip_button = $CanvasLayer / Text / Panel / Skip
onready var text_dark = $CanvasLayer / Text / Dark
onready var points_sprite = $CanvasLayer / Text / Pts
onready var cards_sprite = $CanvasLayer / Text / Cards
onready var round1 = $Round1
onready var round2 = $Round2
onready var round3 = $Round3
onready var round4 = $Round4
onready var round5 = $Round5
onready var clownbody = $Clown
onready var tween = $Tween
onready var voice2 = $Voice2
onready var nose_button = $Nose


var set_time = rand_range(0.5, 2)
var can_light = true
var numbers = []
var dice_values = []
var dice_dark_values = " "
var points = 0
var plus_points = 0
var plus = false
var plays = 9
var plays_card = 9
var gameOver = false
var reroll = 3
var press_no = false
var numbers_pivot = []
var points_minus = false
var rounds = 0


func _ready()->void :
	OS.center_window()
	text_points.text = ": " + str(points)
	randomize()
	Global.text = 1
	dialog.visible = true
	Global.talking = true
	
	if Global.idioma == "español":
		yes_button.text = "Sí"
		skip_button.text = "Saltar"
	else :
		yes_button.text = "Yes"
		skip_button.text = "Skip"


func _process(_delta)->void :
	text()
	if not gameOver:
		light_room()
	misc()
	if Global.text == 21:
		if not voice.playing:
			voice.play()
			clown.show_animation(6)
			yield (get_tree().create_timer(0.6), "timeout")
			clown.show_animation(0)


func misc()->void :
	if Global.talking:
		dice_button.disabled = true
		dice_dark_button.disabled = true
		card_button.disabled = true
	if Global.new_game:
		Global.new_game = false
		dice_dark_button.disabled = false
		card_button.disabled = false
	if Global.game_start:
		Global.game_start = false
		dice_dark_button.disabled = false
		card_button.disabled = false
		text_points.visible = true
		points_sprite.visible = true
		text_plays.visible = true
		cards_sprite.visible = true
		reroll_text.visible = true
		reroll_sprite.visible = true
		rounds = 1
	if Global.voice:
		Global.voice = false
		if Global.text == 13:
			if not really_dark_voice.playing:
				really_dark_voice.play()
			clown.show_animation(6)
			yield (get_tree().create_timer(0.6), "timeout")
			clown.show_animation(0)
		else :
			if not gameOver and Global.text != - 1:
				if not voice.playing:
					voice.play()
				clown.show_animation(6)
				yield (get_tree().create_timer(0.6), "timeout")
				clown.show_animation(0)
	if Global.victory:
		Global.level = 1
		
		get_tree().change_scene("res://Scenes/loading.tscn")


func light_room()->void :
	if not light.enabled and can_light:
		if Global.insane:
			set_time = 0.1
		else :
			set_time = rand_range(0.5, 1)
		light_out.wait_time = set_time
		light_out.start()
		can_light = false

func text()->void :
	if plus:
		text_points.text = ": " + str(points)
		plus = false
	text_plays.text = ": " + str(plays)
	reroll_text.text = ": " + str(reroll)
	if rounds == 1:
		round1.visible = true
		round2.visible = false
		round3.visible = false
		round4.visible = false
		round5.visible = false
	elif rounds == 2:
		round1.visible = false
		round2.visible = true
		round3.visible = false
		round4.visible = false
		round5.visible = false
	elif rounds == 3:
		round1.visible = false
		round2.visible = false
		round3.visible = true
		round4.visible = false
		round5.visible = false
	elif rounds == 4:
		round1.visible = false
		round2.visible = false
		round3.visible = false
		round4.visible = true
		round5.visible = false
	elif rounds == 5:
		round1.visible = false
		round2.visible = false
		round3.visible = false
		round4.visible = false
		round5.visible = true
	else :
		round1.visible = false
		round2.visible = false
		round3.visible = false
		round4.visible = false
		round5.visible = false

func _on_Timer_timeout()->void :
	if not gameOver:
		light.enabled = false
		electric.playing = true
		can_light = true


func _on_Timer2_timeout()->void :
	if not gameOver:
		set_time = rand_range(0.5, 2)
		light_timer.wait_time = set_time
		light_timer.start()
		light.enabled = true
		electric.playing = true


func _on_Cards_pressed()->void :
	plays -= 1
	card.play()
	card_button.disabled = true
	dice_dark_button.disabled = true
	ShowCard()


func ShowCard()->void :
	var spawnCard = card_show.instance()
	call_deferred("add_child", spawnCard)
	spawnCard.position = Vector2(300, - 200)
	yield (get_tree().create_timer(1), "timeout")
	dice_button.disabled = false


func ShowDice()->void :
	var spawnDice = dice_show.instance()
	call_deferred("add_child", spawnDice)
	spawnDice.position = Vector2(1600, 320)
	yield (get_tree().create_timer(0.1), "timeout")
	var spawnDice2 = dice_show.instance()
	call_deferred("add_child", spawnDice2)
	spawnDice2.position = Vector2(1700, 500)
	yield (get_tree().create_timer(0.2), "timeout")
	var spawnDice3 = dice_show.instance()
	call_deferred("add_child", spawnDice3)
	spawnDice3.position = Vector2(1500, 510)
	yield (get_tree().create_timer(1), "timeout")
	check_values()


func _on_Dice_pressed()->void :
	dices.play()
	dice_button.disabled = true
	ShowDice()


func set_values_dice(x, y, z)->void :
	numbers = [x, y, z]
	numbers_pivot = [x, y, z]


func dice_value(n)->void :
	dice_values.append(n)


func check_values()->void :
	for i in dice_values.size():
		for j in numbers.size():
			if numbers[j] == dice_values[i]:
				plus_points += 1
				dice_values[i] = "0"
				numbers[j] = "7"
	if reroll > 0:
		Global.text = 14
		Global.ask_reroll = true
		dialog.visible = true
		Global.talking = true
		Global.voice = true
		dialog.visible = true
		yes_button.visible = true
		no_button.visible = true
		yes_button.disabled = false
		no_button.disabled = false
	else :
		Global.ask_reroll = false
		check_lists()


func check_lists()->void :
	if not press_no:
		yield (get_tree().create_timer(2), "timeout")
	else :
		press_no = false
		yield (get_tree().create_timer(1), "timeout")
	text_plus.visible = true
	if plus_points == 1:
		if Global.idioma == "español":
			text_plus.text = str(plus_points) + " punto"
		else :
			text_plus.text = str(plus_points) + " point"
	else :
		if Global.idioma == "español":
			text_plus.text = str(plus_points) + " puntos"
		else :
			text_plus.text = str(plus_points) + " points"
	clown_animation()
	yield (get_tree().create_timer(1), "timeout")
	Global.erase = true
	numbers = []
	dice_values = []
	yield (get_tree().create_timer(1), "timeout")
	text_plus.visible = false
	points += plus_points
	plus_points = 0
	Global.erase = false
	plus = true
	if plays > 0:
		card_button.disabled = false
		dice_dark_button.disabled = false
	else :
		yield (get_tree().create_timer(1), "timeout")
		new_game()


func new_game()->void :
	if plays_card == 5 and points >= 10:
			Global.ask_reroll = false
			Global.ask_roll = false
			Global.text = 17
			Global.talking = true
			dialog.visible = true
			Global.voice = true
	elif points >= 10:
		if points > 10:
			Global.extra_roll = true
			reroll += 1
		Global.ask_reroll = false
		Global.ask_roll = false
		Global.text = 11
		Global.talking = true
		dialog.visible = true
		if plays_card > 5:
			plays_card -= 1
		rounds += 1
		plus = true
		points = 0
		plays = plays_card
	else :
		Game_over()


func Game_over()->void :
	Global.ask_reroll = true
	gameOver = true
	bulb.play()
	light.enabled = true
	light.shadow_enabled = false
	light.mode = Light2D.MODE_MASK
	light.energy = 1
	Global.text = 13
	yield (get_tree().create_timer(1.5), "timeout")
	Global.talking = true
	dialog.visible = true
	clown.show_animation(5)
	yield (get_tree().create_timer(2), "timeout")
	
	get_tree().change_scene("res://Scenes/Game_over.tscn")


func clown_animation()->void :
	if plus_points == 0:
		clown.show_animation(1)
		laugh.play()
	elif plus_points == 1:
		clown.show_animation(4)
		voice.play()
	elif plus_points == 2:
		clown.show_animation(2)
		dark_voice.play()
	elif plus_points >= 3:
		clown.show_animation(3)
		really_dark_voice.play()
	yield (get_tree().create_timer(2), "timeout")
	clown.show_animation(0)


func clown_animation_dark_dice()->void :
	if dice_dark_values in ["3", "5"] and points_minus:
		points_minus = false
		clown.show_animation(1)
		laugh.play()
	else :
		clown.show_animation(4)
		voice.play()
	yield (get_tree().create_timer(2), "timeout")
	clown.show_animation(0)

func _on_Button_pressed()->void :
	honk.play()
	honk_nose.visible = true
	yield (get_tree().create_timer(0.1), "timeout")
	honk_nose.visible = false


func _on_DiceDark_pressed()->void :
	Global.ask_roll = true
	Global.text = 15
	dialog.visible = true
	Global.talking = true
	Global.voice = true
	yes_button.visible = true
	no_button.visible = true
	yes_button.disabled = false
	no_button.disabled = false

func die_dark_yes()->void :
		
		
		card_button.disabled = true
		dicedark.play()
		dice_dark_button.disabled = true
		ShowDiceDark()


func dice_dark_value(n)->void :
	dice_dark_values = n


func ShowDiceDark()->void :
	var spawnDiceDark = dice_dark_show.instance()
	call_deferred("add_child", spawnDiceDark)
	spawnDiceDark.position = Vector2(1600, 420)
	yield (get_tree().create_timer(1), "timeout")
	check_face()


func check_face()->void :
	yield (get_tree().create_timer(1), "timeout")
	if dice_dark_values == "5":
		points_minus = true
		if Global.idioma == "español":
			text_dark.text = "Pierdes 1 punto"
		else :
			text_dark.text = "You lose 1 point"
		points -= 1
		plus = true
	elif dice_dark_values == "3":
		if plays > 0:
			points_minus = true
			if Global.idioma == "español":
				text_dark.text = "Pierdes 1 carta"
			else :
				text_dark.text = "You lose 1 card"
			plays -= 1
		else :
			if Global.idioma == "español":
				text_dark.text = "No puedes perder cartas"
			else :
				text_dark.text = "You can¡t lose cards"
	elif dice_dark_values in ["1", "2", "4", "6"]:
		if Global.idioma == "español":
			text_dark.text = "Obtienes 1 carta"
		else :
			text_dark.text = "You get 1 card"
		plays += 1
	text_dark.visible = true
	clown_animation_dark_dice()
	yield (get_tree().create_timer(2), "timeout")
	text_dark.visible = false
	Global.erase = true
	yield (get_tree().create_timer(0.5), "timeout")
	if plays == 0:
			new_game()
	Global.erase = false
	card_button.disabled = false


func _on_Yes_pressed()->void :
	if Global.ask_reroll:
		if reroll > 0:
			reroll -= 1
		dialog.visible = false
		press_no = true
		Global.dice_erase = true
		dice_values = []
		set_values_dice(numbers_pivot[0], numbers_pivot[1], numbers_pivot[2])
		plus_points = 0
		card_button.disabled = true
		dice_dark_button.disabled = true
		yield (get_tree().create_timer(0.5), "timeout")
		Global.dice_erase = false
		yes_button.visible = false
		no_button.visible = false
		yes_button.disabled = true
		no_button.disabled = true
		Global.talking = false
		Global.ask_roll = false
		_on_Dice_pressed()
	else :
		dialog.visible = false
		yes_button.visible = false
		no_button.visible = false
		yes_button.disabled = true
		no_button.disabled = true
		Global.talking = false
		die_dark_yes()


func _on_No_pressed()->void :
	if Global.ask_reroll:
		dialog.visible = false
		press_no = true
		yes_button.visible = false
		no_button.visible = false
		yes_button.disabled = true
		no_button.disabled = true
		Global.ask_reroll = false
		Global.talking = false
		check_lists()
	else :
		dialog.visible = false
		yes_button.visible = false
		no_button.visible = false
		yes_button.disabled = true
		no_button.disabled = true
		Global.talking = false
		Global.ask_roll = false
		dice_dark_button.disabled = false
		card_button.disabled = false


func _on_Skip_pressed()->void :
	Global.skip = true
	dialog.visible = false


func _on_DeadFace_animation_finished()->void :
	yield (get_tree().create_timer(3), "timeout")
	tween.interpolate_property(clownbody, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()


func _on_Tween_tween_all_completed()->void :
	nose_button.disabled = true
	yield (get_tree().create_timer(3), "timeout")
	Global.victory = true
	
func ahia(n)->void :
	if n:
		if not voice2.playing:
			voice2.play()
	else :
		voice2.play()
