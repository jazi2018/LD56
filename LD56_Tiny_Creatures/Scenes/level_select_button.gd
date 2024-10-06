class_name LevelSelectButton
extends Button

#make sure to update level_path (IN THE INSPECTOR) to the desired scene
@export var level_path : String = "res://Scenes/"

func _ready() -> void:
	self.pressed.connect(_on_button_press)

func _on_button_press() -> void:
	Events.scene_change_requested.emit(level_path)
