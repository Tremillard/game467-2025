extends Control
const PASSWORD = "32 180 1888"
var pointer = 0
var can_print = true
@onready var text = $VBoxContainer/MarginContainer/Label.text

func _process(delta):
	$VBoxContainer/MarginContainer/Label.text = text
	if pointer == 2:
		pointer = 3
	if pointer == 6:
		pointer = 7
	if pointer == 11:
		can_print = false
func key_press(digit):
	if can_print:
		text[pointer] = str(digit)
		pointer += 1
		print(text)
		


func _on_button_pressed():
	key_press(1)


func _on_button_2_pressed():
	key_press(2)


func _on_button_3_pressed():
	key_press(3)


func _on_button_4_pressed():
	key_press(4)


func _on_button_5_pressed():
	key_press(5)


func _on_button_6_pressed():
	key_press(6)


func _on_button_7_pressed():
	key_press(7)


func _on_button_8_pressed():
	key_press(8)


func _on_button_9_pressed():
	key_press(9)


func _on_button_clear_pressed():
	text = "XX XXX XXXX"
	pointer = 0
	can_print = true


func _on_button_0_pressed():
	key_press(0)


func _on_button_enter_pressed():
	if text == PASSWORD:
		print("yay")


func _on_done_pressed():
	hide()
