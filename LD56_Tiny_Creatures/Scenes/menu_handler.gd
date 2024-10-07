extends Control

@onready var start_button := $StartButton

@export var duration := 1 #tween duration

var button_pressed := false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_start_button_button_up():
	if !button_pressed:
		self.mouse_filter = Control.MOUSE_FILTER_IGNORE
		var tween := get_tree().create_tween()
		tween.tween_property(self, "modulate", Color.TRANSPARENT, duration).set_trans(Tween.TRANS_LINEAR)
		await tween.finished
		self.visible = false
