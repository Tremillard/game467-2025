extends Node2D

var currently_used_item
# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("usability_trigger",on_usability_trigger)
	SignalBus.connect("enter",on_enter_room)
	SignalBus.connect("item_chosen",on_choose_item)
	#$BlackBackground.show()
	#SignalBus.emit_signal("display_conversation", Cutscenes.intro, Cutscenes.introspeaker, "introcutscene")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	check_story_flags()
	
func _input(event):
	pass

func on_usability_trigger(key):
	Global.using_item = true
	var targetkey = key.key
	await SignalBus.item_chosen
	if currently_used_item == targetkey:
		cause_change(targetkey)
		$Inventory_UI.remove_item(targetkey)
		$Inventory_UI.check_inventory()
		#spend the item
	else: cause_change("nothing")
	Global.using_item = false

func cause_change(key):
	if key == "left_door_key":
		pass
	if key == "bone":
		SignalBus.emit_signal("display_dialogue", Cutscenes.give_dog_bone)
		$"Manor_Prehist/Cave Key Default".hide()
		$"Manor_Prehist/Grug Default".hide()
		$"Manor_Prehist/Cave Key Takeable".show()
		$"Manor_Prehist/Grug Happy".show()
		$Manor_Prehist/Dog.hide()
		$Manor_Prehist/DogNoUse.show()
	if key == "nothing":
		SignalBus.emit_signal("display_dialogue", Cutscenes.nothing)

func on_enter_room(destination):
	if destination == "prehistoric":
		$Manor.hide()
		$Manor_Prehist.show()
		Global.current_room = "prehistoric"
	if destination == "manor":
		$Manor.show()
		$Manor_Prehist.hide()
		Global.current_room = "manor"

func on_choose_item(itemkey):
	currently_used_item = itemkey
	
func check_story_flags():
	if StoryFlags.has_listened_to_walkie == true:
		$"Manor_Prehist/Grug Happy".switch_resource(load("res://Resources/grugidentity.tres"))

	
