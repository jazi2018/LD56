extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.level_completed.connect(_on_level_completed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_level_completed() -> void:
	pass
