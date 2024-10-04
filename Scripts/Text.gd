extends Control

var CHAR_READ_RATE = 0.03

onready var label = $Bla
onready var tween = $Tween
onready var cursor = $Next
onready var animation = $AnimationPlayer
onready var panel = $Fondo
onready var skip_button = $Skip


var enter = false
var mouse = false
var text = " "
var talking = false
var already_skip = false

func _ready()->void :
	cursor.visible = false
	animation.current_animation = "Move"


func _process(_delta)->void :
	talk(Global.talking)
	if enter and mouse:
		if Input.is_mouse_button_pressed(1):
			enter = false
			label.visible = false
			if Global.text == 13:
				text = " "
				pass
			if Global.text < 10:
				Global.text += 1
			elif Global.text == 11:
				Global.text += 1
			elif Global.text == 10:
				text = " "
				Global.skip = true
				pass
			elif Global.extra_roll:
				Global.extra_roll = false
				Global.text = 16
			elif Global.text >= 17 and Global.text < 21:
				Global.text += 1
			elif Global.text == 21:
				Global.end = true
				text = " "
				Global.text = - 1
				talking = false
				Global.talking = false
				pass
			else :
				if Global.text == 12 or Global.text == 16:
					label.visible = false
					Global.new_game = true
				text = " "
				Global.text = - 1
				talking = false
				Global.talking = false
				pass
			if already_skip:
				already_skip = false
				pass
			label.visible = false
			cursor.visible = false
			text_select(Global.text)
	if not label.visible or not self.visible:
		text = " "
	if Global.skip:
		label.visible = false
		already_skip = true
		Global.skip = false
		skip_button.disabled = true
		skip_button.visible = false
		mouse = false
		cursor.visible = false
		Global.text = - 1
		talking = false
		text = " "
		Global.talking = false
		self.visible = false
		Global.game_start = true


func talk(n)->void :
	if n and not talking:
		talking = true
		label.visible = false
		text_select(Global.text)
	if not n:
		talking = false
		label.visible = false


func text_select(n)->void :
	if n == 1:
		if Global.idioma == "español":
			text = "Vamos a jugar."
		else :
			text = "Let's play a game."
		skip_button.disabled = false
		skip_button.visible = true
	elif n == 2:
		if Global.idioma == "español":
			text = "Toma una carta y tira los 3 dados."
		else :
			text = "Take a card and then roll all 3 dice."
	elif n == 3:
		if Global.idioma == "español":
			text = "Por cada acierto obtienes 1 punto."
		else :
			text = "For each hit you get a point."
	elif n == 4:
		if Global.idioma == "español":
			text = "Jugaremos 5 rondas."
		else :
			text = "We will play 5 rounds."
	elif n == 5:
		if Global.idioma == "español":
			text = "Alcanza al menos 10 puntos para pasar de ronda."
		else :
			text = "Reach at least 10 points to go to the next round."
	elif n == 6:
		if Global.idioma == "español":
			text = "Consigue más de 10 puntos y te daré un volver a lanzar los dados adicional."
		else :
			text = "If you finish a round with more than 10 points you get 1 extra reroll."
	elif n == 7:
		if Global.idioma == "español":
			text = "También puedes tirar el dado grande para obtener una carta adicional."
		else :
			text = "You can also roll the big die to get an extra card."
	elif n == 8:
		if Global.idioma == "español":
			text = "Pero ten cuidado, solo tienes un 66,6 % de acertar."
		else :
			text = "But beware, you only have 66,6 percent chance of hitting."
	elif n == 9:
		if Global.idioma == "español":
			text = "Empiezas con 9 cartas, 0 puntos y 3 volver a lanzar los dados."
		else :
			text = "You start with 9 cards, 0 points and 3 rerolls."
	elif n == 10:
		if Global.idioma == "español":
			text = "Buena suerte."
		else :
			text = "Good luck."
	elif n == 11:
		if Global.idioma == "español":
			text = "Siguiente ronda."
		else :
			text = "Next round."
	elif n == 12:
		if Global.idioma == "español":
			text = "Pero esta vez con menos cartas."
		else :
			text = "But this time with fewer cards."
	elif n == 13:
		if Global.idioma == "español":
			text = "Fin del juego."
		else :
			text = "Game Over."
	elif n == 14:
		if Global.idioma == "español":
			text = "¿Quieres volver a lanzar los dados?"
		else :
			text = "Would you like to reroll the dice?"
	elif n == 15:
		if Global.idioma == "español":
			text = "¿Quieres tirar este dado?"
		else :
			text = "Would you like to roll this die?"
	elif n == 16:
		if Global.idioma == "español":
			text = "Obtienes 1 volver a lanzar los dados adicional."
		else :
			text = "You got 1 extra reroll."
	elif n == 17:
		if Global.idioma == "español":
			text = "Ga ..."
		else :
			text = "You ..."
	elif n == 18:
		if Global.idioma == "español":
			text = "Ganaste ..."
		else :
			text = "You won ..."
	elif n == 19:
		if Global.idioma == "español":
			text = "De verdad ganaste."
		else :
			text = "You really won."
	elif n == 20:
		if Global.idioma == "español":
			text = "No puede ser."
		else :
			text = "It can not be."
	elif n == 21:
		if Global.idioma == "español":
			text = "¡Improbable! ¡Improbable! ¡Improbable! ¡Improbable! ¡Improbable! ¡Improbable! ¡Improbable! ¡Improbable! ¡Improbable! ¡Improbable! ¡Improbable! ¡Improbable! ¡Improbable! ¡Improbable! "
		else :
			text = "Unlikely! Unlikely! Unlikely! Unlikely! Unlikely! Unlikely! Unlikely! Unlikely! Unlikely! Unlikely! Unlikely! Unlikely! Unlikely! Unlikely! Unlikely! Unlikely! Unlikely!"
	else :
		text = " "
		self.visible = false
		mouse = false
		pass
	add_text(text)


func add_text(Text)->void :
	Global.voice = true
	label.percent_visible = 0.0
	label.text = Text
	tween.interpolate_property(label, "percent_visible", 0.0, 1.0, len(Text) * CHAR_READ_RATE, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	label.visible = true


func _on_Tween_tween_all_completed()->void :
	if not Global.ask_reroll and not Global.ask_roll:
		cursor.visible = true
		enter = true
	if not self.visible:
		cursor.visible = false


func _on_Fondo_mouse_entered()->void :
	if not Global.ask_reroll and not Global.ask_roll:
		mouse = true


func _on_Fondo_mouse_exited()->void :
	mouse = false
