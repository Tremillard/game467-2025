extends Node

# inventory items
var inventory = []
#Selected Object important to bus information of object to dialogue
@export var Selected_Object : Node
#added_item important to bus information to inventory
@export var added_item : Takeable
#Reading in Progess important to check if more dialogue can appear
@export var reading_in_progress : bool
#Array of the keys in your inventory, important to see if you can "use" stuff
@export var inventory_keys : Array
# Current Room key
@export var current_room : String
# Whether player is using an item or not dictates if some UI elements appear
@export var using_item : bool
