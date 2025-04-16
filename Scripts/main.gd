extends Node2D

var currently_used_item
# Called when the node enters the scene tree for the first time.
func _ready():
	#Connect Signals
	SignalBus.connect("usability_trigger",on_usability_trigger)
	SignalBus.connect("enter",on_enter_room)
	SignalBus.connect("item_chosen",on_choose_item)
	
	# Detect which room is currently visible and store it
	SignalBus.connect("inspect_show",on_inspect_show)

	for child in get_children():
		if child is Node2D and child.visible:
			match child.name:
				"Manor":
					Global.current_room = "manor"
				"Manor_Prehist":
					Global.current_room = "prehistoric"
				"Manor_Saloon":
					Global.current_room = "saloon"
			break
	#$BlackBackground.show()
	#SignalBus.emit_signal("display_conversation", Cutscenes.intro, Cutscenes.introspeaker, "introcutscene")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#This is to trigger cutscenes/change item resoureces
	check_story_flags()
	
func _input(event):
	if event.is_action_pressed("save_game"):
		SaveManager.save_game()
	elif event.is_action_pressed("load_game"):
		SaveManager.apply_save_data()

#Triggers when "Use" is selected from Clickable Options
#It turns off some click functionality so the game doesn't get confused
func on_usability_trigger(key):
	Global.using_item = true
	var targetkey = key.key
	#Stall until item is selected
	await SignalBus.item_chosen
	if currently_used_item == targetkey:
		cause_change(targetkey)
		$Inventory_UI.remove_item(targetkey)
		$Inventory_UI.check_inventory()
		#spend the item and change something
	else: 
		cause_change("nothing")
	Global.using_item = false

#Function for changing all of the things in the game
#Triggers off of usability trigger
func cause_change(key):
	if key == "left_door_key":
		pass
	if key == "saloon_key":
		$"Manor/Middle Door".switch_resource(load("res://Resources/saloon_unlocked_enterable.tres"))
		$"Manor/Middle Door".switch_resource(load("res://Resources/saloon_unlocked_inspectable.tres"))
		$"Manor/Middle Door".switch_resource(load("res://Resources/usable.tres"))
		SignalBus.emit_signal("display_dialogue", Cutscenes.unlock_saloon_door)
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

#Function for changing between all of the rooms in the game
#Hardcoded because it's a small game haha
func on_enter_room(destination):
	if destination == "prehistoric":
		$Manor.hide()
		$Manor_Saloon.hide()
		$Manor_Prehist.show()
		Global.current_room = "prehistoric"
	if destination == "manor":
		$Manor.show()
		$Manor_Saloon.hide()
		$Manor_Prehist.hide()
		Global.current_room = "manor"
	if destination == "saloon":
		$Manor.hide()
		$Manor_Prehist.hide()
		$Manor_Saloon.show()
		Global.current_room = "saloon"


func on_choose_item(itemkey):
	currently_used_item = itemkey

func on_inspect_show(show_key):
	if show_key == "safe":
		Global.in_menu = true
		await get_tree().create_timer(1.3).timeout 
		$Manor_Saloon/Keypad.show()
		
#Function to trigger cutscenes/change item resoureces
func check_story_flags():
	if StoryFlags.has_listened_to_walkie == true:
		$"Manor_Prehist/Grug Happy".switch_resource(load("res://Resources/grugidentity.tres"))
		
