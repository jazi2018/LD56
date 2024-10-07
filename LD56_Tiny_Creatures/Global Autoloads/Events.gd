extends Node

#menu management
signal scene_change_requested(scene_path: String)

#hub management
var hub_active : bool
signal hub_entered
signal hub_exited

#level functionality
signal level_completed

#level loading
var current_creatures : int #current creatures in bucket
signal creatures_shipped(num: int)

#creature design
var creature_count := 0
signal creature_created

func _ready() -> void:
	creatures_shipped.connect(_store_num_creatures)
	hub_entered.connect(_on_hub_entered)
	hub_exited.connect(_on_hub_exited)
	creature_created.connect(_on_creature_created)
	current_creatures = 0
	hub_active = true

func _store_num_creatures(num: int) -> void:
	current_creatures = num

func _get_creatures() -> int:
	return current_creatures

func _on_hub_entered() -> void:
	hub_active = true

func _on_hub_exited() -> void:
	hub_active = false

func _on_creature_created() -> void:
	creature_count += 1
