class_name Creature
extends RigidBody2D

const SPRING_CONSTANT := 300

var is_in_hub: bool = false
var is_grabbed: bool = false
var has_mouse: bool = false
var holding: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#TODO
	#check if creature is in hub
	pass

func _physics_process(delta) -> void:
	if Input.is_action_just_pressed("left_click") and has_mouse:
		holding = true
	
	if Input.is_action_just_released("left_click"):
		holding = false
	
	if holding:
		apply_central_impulse(SPRING_CONSTANT * get_local_mouse_position() * delta - linear_velocity/4)

func _on_mouse_entered():
	has_mouse = true

func _on_mouse_exited() -> void:
	has_mouse = false
