extends CharacterBody2D
class_name Interactable

#We use custom resources for the data, check their scripts for more info
@export var inspectable_text = Inspectable
@export var takeable_text = Takeable
@export var talkable_text = Talkable


func _on_mouse_entered():
	$Sprite2D.modulate = Color(1,1,1)
	GlobalVars.Selected_Object = self

func _on_mouse_exited():
	$Sprite2D.modulate = Color(0,0,0)
	GlobalVars.Selected_Object = null
