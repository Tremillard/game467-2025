extends CharacterBody2D
class_name Interactable

#We use custom resources for the data, check their scripts for more info
@export var inspectable_text = Resource
@export var takeable_info = Resource
@export var talkable_text = Resource

func _on_mouse_entered():
	$Sprite2D.modulate = Color(1,1,1)
	Global.Selected_Object = self

func _on_mouse_exited():
	$Sprite2D.modulate = Color(0,0,0)
	Global.Selected_Object = null
