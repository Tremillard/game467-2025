extends CharacterBody2D
class_name Interactable

#We use custom resources for the data, check their scripts for more info
@export var inspectable_res = Resource
@export var takeable_res = Resource
@export var talkable_res = Resource
@export var usable_res = Resource
@export var enterable_res = Resource

func _on_mouse_entered():
	Global.Selected_Object = self

func _on_mouse_exited():
	if Global.Selected_Object == self:
		Global.Selected_Object = null

# Switches from resource A to resource B - 
# essentially switching what text shows

func switch_resource(new_resource):
	if new_resource is Talkable:
		talkable_res = new_resource
	if new_resource is Inspectable:
		inspectable_res = new_resource
	if new_resource is Enterable:
		enterable_res = new_resource
	if new_resource is Takeable:
		takeable_res = new_resource
	if new_resource is Usable:
		usable_res = new_resource
