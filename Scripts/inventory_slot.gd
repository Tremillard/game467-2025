extends Control

@onready var icon = $InnerBorder/Itemicon
@onready var quantity_label = $InnerBorder/ItemQuantity
@onready var details_panel = $DetailsPanel
@onready var item_name = $DetailsPanel/ItemName
@onready var item_type = $DetailsPanel/ItemType
@onready var item_effect = $DetailsPanel/ItemEffect
@onready var usage_panel = $UsagePanel

var item = null

func set_item(new_item):
	item = new_item
	item_name.text = item.item_name
	item_type.text = item.text
	icon.texture = item.texture

func _on_check_button_pressed():
	print(item.text)

func _on_use_button_pressed():
	print("Usage coming soon!")
	$UsagePanel.hide()

func _on_item_button_pressed():
	if $UsagePanel.visible == false and item != null:
		$UsagePanel.show()
	elif $UsagePanel.visible == true:
		$UsagePanel.hide()
