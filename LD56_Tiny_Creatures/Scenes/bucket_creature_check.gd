extends Area2D

@onready var timer := $Timer
var required_creatures : int
var creature_count := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# vvv for testing if level is main scene
	#Events.creatures_shipped.emit(1)
	required_creatures = Events.current_creatures


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if timer.is_stopped() and creature_count == required_creatures:
		timer.start()
	elif creature_count != required_creatures:
		timer.stop()


func _on_timer_timeout():
	Events.level_completed.emit()
	Events.scene_change_requested.emit("res://Scenes/Hub.tscn")


func _on_body_entered(body):
	print("Creature count before: ", creature_count)
	creature_count += 1
	print("Creature count after: ", creature_count)


func _on_body_exited(body):
	print("Creature count before: ", creature_count)
	creature_count -= 1
	print("Creature count after: ", creature_count)
