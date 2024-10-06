extends Node

@onready var level_select := "res://Scenes/LevelSelect.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	Events.scene_change_requested.connect(_on_scene_change_requested)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

#currently ONLY goes to level select, can be modified later since
#scene change requested signal allows for string param which can
#be path to desired scene
func _on_scene_change_requested():
	get_tree().change_scene_to_file(level_select)
