extends Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	await self.timeout
	Events.scene_change_requested.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
