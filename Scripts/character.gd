extends CharacterBody2D

# variables
@export var speed = 200

@onready var interact_ui = $InteractUI
@onready var inventory_ui = $Inventory_UI

func _ready():
	# set player reference
	Global.set_player_reference(self)
	

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed
	
func _physics_process(delta):
	get_input()
	move_and_slide()

func _input(event):
	if event.is_action_pressed("ui_inventory"):
		inventory_ui.visible = !inventory_ui.visible
		get_tree().paused = !get_tree().paused
