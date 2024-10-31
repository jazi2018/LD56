extends Area2D

@export var scene_path : String = "res://Scenes/Hub.tscn"
@onready var timer := $Timer
var required_creatures : int
var creature_count := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# vvv for testing if level isnt hub scene
	Events.creatures_shipped.emit(1)
	required_creatures = Events.current_creatures


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if timer.is_stopped() and creature_count == required_creatures:
		timer.start()
	elif creature_count != required_creatures:
		timer.stop()


func _on_timer_timeout():
	Events.level_completed.emit()
	Events.scene_change_requested.emit(scene_path)


func _on_body_entered(_body):
	creature_count += 1


func _on_body_exited(_body):
	creature_count -= 1
