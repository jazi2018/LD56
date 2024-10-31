extends StaticBody2D

var original_pos := self.position.x
# Called when the node enters the scene tree for the first time.
func _ready():
	var tween := get_tree().create_tween().set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "position:x", original_pos + 600, 1.5)
	await tween.finished
	var tween2 := get_tree().create_tween().set_trans(Tween.TRANS_QUAD)
	tween2.tween_property(self, "position:x", original_pos, 1.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
