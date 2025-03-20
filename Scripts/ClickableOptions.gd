extends VBoxContainer

#Variables for storing the info of selected objects
var inspectable_script = Inspectable
var takeable_script = Takeable
var talkable_script = Talkable
var usable_script = Usable
var enterable_room = Enterable
var talkable_speaker
#Variables for storing the object, and if it's takeable
var selected = Global.Selected_Object #shorthand
var selected_takeable

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	selected = Global.Selected_Object

#Read click inputs over selected objects
func _input(event):
	if event is InputEventMouseButton:
		#When you click, if there's a selected object 
		#and the UI isn't reading, show the options
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_released() and selected != null and Global.reading_in_progress == false:
			_is_clicked()

#When something is clicked show the UI and check what buttons should show
func _is_clicked():
	self.show()
	self.position = get_global_mouse_position() #+ Vector2(60,-96)
	check_ability()

#check what the object is and stores data of it
func check_ability():
	$Inspect.hide()
	$Take.hide()
	$Talk.hide()
	$Use.hide()
	$Enter.hide()
	if selected.inspectable_res.show == true:
		$Inspect.show()
		inspectable_script = selected.inspectable_res.text
	if selected.takeable_res.show == true:
		$Take.show()
		takeable_script = selected.takeable_res.pick_up_text
		selected_takeable = selected
	if selected.talkable_res.show == true:
		$Talk.show()
		talkable_script = selected.talkable_res.text
		talkable_speaker = selected.talkable_res.speaker
	if selected.usable_res.show == true:
		$Use.show()
		usable_script = selected.usable_res
	if selected.enterable_res.show == true:
		$Enter.show()
		enterable_room = selected.enterable_res

#When the UI buttons are pressed, show the info and perform auxillary action (take the object)
func _on_inspect_pressed():
	SignalBus.emit_signal("display_dialogue", inspectable_script)
	self.hide()
func _on_take_pressed():
	selected_takeable.takeable_res.take_item()
	SignalBus.emit_signal("display_dialogue", takeable_script)
	selected_takeable.queue_free()
	self.hide()
func _on_talk_pressed():
	SignalBus.emit_signal("display_conversation", talkable_script, talkable_speaker)
	self.hide()
func _on_cancel_pressed():
	self.hide()

func _on_use_pressed():
	SignalBus.emit_signal("usability_trigger", usable_script)
	#Talk to main about what the use function should be
	self.hide()

func _on_enter_pressed():
	SignalBus.emit_signal("enter", enterable_room.destination)
	self.hide()
