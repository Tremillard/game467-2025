extends Node

var save_file_path: String = "user://savegame.json"

func save_game():
	var save_data = {}

	# 1) Save the Current Room
	var current_room = get_current_room_name()
	save_data["current_room"] = current_room

	# 2) Save the Inventory
	var inventory_data = []
	var main_node = get_node("/root/Main")
	var inventory_ui = main_node.get_node("Inventory_UI")
	var grid_container = inventory_ui.get_node("GridContainer")
	for slot in grid_container.get_children():
		if slot.item:
			inventory_data.append({
				"item_key": slot.key
			})
		else:
			inventory_data.append(null)
	save_data["inventory"] = inventory_data

	# 3) Save Story Flags
	save_data["story_flags"] = {
		"has_listened_to_walkie": StoryFlags.has_listened_to_walkie,
		# Add more flags like this:
		"bone_used": StoryFlags.bone_used,
	}

	# 4) Write to File
	var file = FileAccess.open(save_file_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data))
	file.close()
	print("Game saved at: ", save_file_path)


func load_game() -> Dictionary:
	var file = FileAccess.open(save_file_path, FileAccess.READ)
	if file == null:
		print("No save file found.")
		return {}

	var content = file.get_as_text()
	var parsed = JSON.parse_string(content)

	if typeof(parsed) != TYPE_DICTIONARY:
		print("Error parsing save file.")
		return {}

	return parsed


func apply_save_data():
	var data = load_game()
	if data.is_empty():
		print("No save data to load.")
		return

	var main = get_node("/root/Main")

	# 1) Restore Room
	for child in main.get_children():
		if child is Node:
			child.hide()

	if data.has("current_room"):
		var room_name = data["current_room"]
		var saved_room = main.get_node_or_null(room_name)
		if saved_room:
			saved_room.show()
			print("Loaded and switched to room:", room_name)
		else:
			print("Saved room not found in current scene tree.")

	# 2) Restore Inventory
	if data.has("inventory"):
		var inventory_data = data["inventory"]
		var inventory_ui = main.get_node("Inventory_UI")
		var grid_container = inventory_ui.get_node("GridContainer")

		# Clear existing items
		for slot in grid_container.get_children():
			slot.remove_item()

		# Restore each item
		for i in range(len(inventory_data)):
			var slot_data = inventory_data[i]
			if slot_data != null:
				var item_key = slot_data["item_key"]
				var item_res = load("res://Resources/%s.tres" % item_key)
				if item_res:
					grid_container.get_child(i).set_item(item_res)

	# 3) Restore Story Flags
	if data.has("story_flags"):
		var flags = data["story_flags"]

		if flags.has("has_listened_to_walkie"):
			StoryFlags.has_listened_to_walkie = flags["has_listened_to_walkie"]

		if flags.has("bone_used"):
			StoryFlags.bone_used = flags["bone_used"]
			if flags["bone_used"] == true:
				var bone_node = main.get_node_or_null("Manor_Prehist/Bone")
				if bone_node:
					bone_node.hide()

	print("Game loaded.")


func get_current_room_name() -> String:
	var main = get_node("/root/Main")
	for child in main.get_children():
		if child is Node and child.visible:
			return child.name
	return ""
