extends Control

@onready var grid_container = $GridContainer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	if Global.added_item != null:
		update_inventory()

# Update inventory UI
func update_inventory():
	for slot in $GridContainer.get_children():
		if slot.item == null:
			slot.set_item(Global.added_item)
			Global.added_item = null
			break

func _on_inventory_pressed():
	if visible == false: 
		show() 
	elif visible == true: hide()
