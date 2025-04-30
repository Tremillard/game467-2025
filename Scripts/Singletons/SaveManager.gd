extends Node

var save_path := "user://save_data.save"

func save_game():
	var save_data = {
		"current_room": Global.current_room,
		"story_flags": {
			"has_listened_to_walkie": StoryFlags.has_listened_to_walkie,
			"bone_used":              StoryFlags.bone_used,
			"has_checked_safe":       StoryFlags.has_checked_safe
		}
	}
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(save_data)
	print("Game saved: ", save_data)

func load_game_data() -> Dictionary:
	if not FileAccess.file_exists(save_path):
		print("No save file found.")
		return {}
	var file = FileAccess.open(save_path, FileAccess.READ)
	var save_data = file.get_var()
	print("Game loaded: ", save_data)
	return save_data

func apply_save_data():
	var save_data = load_game_data()

	if save_data.has("current_room"):
		SignalBus.emit_signal("enter", save_data["current_room"])

	if save_data.has("story_flags"):
		var flags = save_data["story_flags"]
		StoryFlags.has_listened_to_walkie = flags.get("has_listened_to_walkie", StoryFlags.has_listened_to_walkie)
		StoryFlags.bone_used              = flags.get("bone_used",              StoryFlags.bone_used)
		StoryFlags.has_checked_safe       = flags.get("has_checked_safe",       StoryFlags.has_checked_safe)
		print("Story flags applied:", flags)
