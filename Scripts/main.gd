extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("usability_trigger",on_usability_trigger)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _input(event):
	pass

func on_usability_trigger(key):
	var usekey = key.key
	print(usekey)
	for i in Global.inventory_keys:
		if i == usekey:
			cause_change(usekey)
			$Inventory_UI.remove_item(usekey)
			$Inventory_UI.check_inventory()
			#spend the item

func cause_change(key):
	if key == "left_door_key":
		pass
			
