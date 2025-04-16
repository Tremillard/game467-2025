extends Node

var save_path := "user://save_data.save"

func save_game():
	var save_data = {
		"current_room": Global.current_room
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
		var room = save_data["current_room"]
		SignalBus.emit_signal("enter", room)  # calls Main.gd's on_enter_room()
