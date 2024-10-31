extends Node

#path to scene
@onready var level_select := "res://Scenes/LevelSelect.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	Events.scene_change_requested.connect(_on_scene_change_requested)


func _on_scene_change_requested(_scene_path: String):
	#Use following code when normal scene selection is implemented
	#get_tree().change_scene_to_file(scene_path)
	
	#this code is temporary until needs to be replaced later
	TransitionScreen.transition()
	await TransitionScreen.scene_transition_finished
	get_tree().change_scene_to_file(level_select)
