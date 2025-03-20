extends Resource
class_name Takeable
signal send_item 

#Resource for takeables. Don't edit this.
@export var show : bool
@export var pick_up_text : String
@export var inspect_text : String
@export var texture : Texture
@export var key : String

func take_item():
	Global.added_item = self
