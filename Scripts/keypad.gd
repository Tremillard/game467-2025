extends Control
const PASSWORD = "32 180 1888"
var pointer = 0
var can_print = true
var text = "XX XXX XXXX"
var selected_text 


func _process(delta):
	if pointer == 2:
		pointer = 3
	if pointer == 6:
		pointer = 7
	if pointer == 11:
		can_print = false
	if $VBoxContainer/MarginContainer/Label.text == "XX XXX XXXX":
		$VBoxContainer/MarginContainer/Label.text = "[color=red]X[/color]X XXX XXXX"
	
func key_press(digit):
	if can_print:
		text[pointer] = str(digit)
		pointer += 1
		selected_text = format_text(text)
		$VBoxContainer/MarginContainer/Label.text = selected_text
		
func format_text(text):
	var new_text = text
	var first_x_index = new_text.find("X")
	if first_x_index > -1:
		new_text[first_x_index] = ""
		new_text = new_text.insert(first_x_index,"[color=red]X[/color]")
	print(new_text)
	return new_text
	

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
	$VBoxContainer/MarginContainer/Label.text = "XX XXX XXXX"
	text = "XX XXX XXXX"
	pointer = 0
	can_print = true


func _on_button_0_pressed():
	key_press(0)


func _on_button_enter_pressed():
	if text == PASSWORD:
		$VBoxContainer/MarginContainer/Label.modulate = Color(0,1,0)
		await get_tree().create_timer(1).timeout
		$VBoxContainer/MarginContainer/Label.modulate = Color(1,1,1)
		print("yay")
		#signal something
		hide()
	else:
		$VBoxContainer/MarginContainer/Label.modulate = Color(1,0,0)
		await get_tree().create_timer(1).timeout
		$VBoxContainer/MarginContainer/Label.modulate = Color(1,1,1)


func _on_done_pressed():
	hide()
