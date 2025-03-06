extends Control

var selected_text
var in_progress = false
@export var text_speed = .1
@onready var text_label = $TextLabel
@onready var background = $Background

func _ready():
	background.visible = false
	SignalBus.connect("display_dialogue",on_display_dialogue)

func _process(delta):
	if Global.Selected_Object == self:
		pass
		#code to make the window scroll faster if the text is not done
		#or close the window/go to the next message if it is
func on_display_dialogue(new_message):
	background.visible = true
	var printed = ""
	in_progress = true
	for i in len(new_message):
		printed += new_message[i]
		text_label.text = printed
		#Play a sound maybe?
		await get_tree().create_timer(text_speed).timeout 
	in_progress = false
func _on_mouse_entered():
	Global.Selected_Object = self


func _on_mouse_exited():
	Global.Selected_Object = null
