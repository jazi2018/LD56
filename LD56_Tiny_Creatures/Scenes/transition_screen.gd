extends CanvasLayer

signal scene_transition_finished

@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer

func ready() -> void:
	color_rect.visible = false

func transition() -> void:
	color_rect.visible = true
	animation_player.play("swipe_to_dark")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "swipe_to_dark":
		scene_transition_finished.emit()
		animation_player.play("swipe_to_normal")
	elif anim_name == "swipe_to_normal":
		color_rect.visible = false
