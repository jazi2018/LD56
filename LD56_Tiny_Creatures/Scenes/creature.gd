#class_name Creature
extends RigidBody2D

@onready var wander_timer := $WanderTimer

@export var SPEED := 5

const SPRING_CONSTANT := 300
enum States {Neutral, Held, Wander, Follow}

var rng := RandomNumberGenerator.new()
var is_in_hub: bool = false
var has_mouse: bool = false
var wander_destination := Vector2.ZERO

var state := States.Neutral
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#start wander timer so wander_destination can be generated
	wander_timer.start()
	#TODO
	#check if creature is in hub
	pass

func _physics_process(delta) -> void:
	if Input.is_action_just_pressed("left_click") and has_mouse:
		state = States.Held
		wander_timer.stop()
	
	if Input.is_action_just_released("left_click"):
		state = States.Neutral
		wander_timer.start()
	
	if state == States.Held:
		apply_central_impulse(SPRING_CONSTANT * get_local_mouse_position() * delta - linear_velocity/4)
	elif state == States.Wander:
		var impulse_x := wander_destination.x - self.position.x
		apply_central_force(Vector2(impulse_x, 0) * SPEED)
	
	if self.position.distance_to(wander_destination) <= 30:
		#print("at destination")
		state = States.Neutral
		self.physics_material_override.friction = 0.6
		if wander_timer.is_stopped():
			wander_timer.start()

func generate_wander_location() -> Vector2:
	#range for randf should be bounds of hub
	#TODO: Improve wandering AI (don't move to a point too close)
	#Include y axis navigation as well (jump when colliding with a wall?)
	var x_pos := rng.randf_range(354, 829)
	return Vector2(x_pos, self.position.y)

func _on_mouse_entered() -> void:
	has_mouse = true

func _on_mouse_exited() -> void:
	has_mouse = false

func _on_wander_timer_timeout() -> void:
	state = States.Wander
	self.physics_material_override.friction = 0.2
	wander_destination = generate_wander_location()
	print(wander_destination)
