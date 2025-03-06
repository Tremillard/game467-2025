extends CharacterBody2D
class_name Interactable

#We use custom resources for the data, check their scripts for more info
@export var inspectable_text = Inspectable
@export var takeable_info = Takeable
@export var talkable_text = Talkable

func _on_mouse_entered():
	Global.Selected_Object = self

func _on_mouse_exited():
	Global.Selected_Object = null
