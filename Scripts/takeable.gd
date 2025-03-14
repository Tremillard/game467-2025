extends Resource
class_name Takeable
signal send_item 

#Resource for takeables. Don't edit this.
@export var text : String
@export var show : bool
@export var item_name : String
@export var texture : Texture
@export var key : String

func take_item():
	Global.added_item = self
