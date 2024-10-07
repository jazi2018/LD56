extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.scene_change_requested.connect(_on_scene_change_requested)


func _on_scene_change_requested(scene_path: String) -> void:
	get_tree().change_scene_to_file(scene_path)
