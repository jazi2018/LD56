extends Node2D

var in_box = false
var area_rect = Rect2(0, 0, 64, 64)
var color = "#E6EEEF"
var grid = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#resize viewport
	get_window().content_scale_size = Vector2i(96, 64)
	#prevent clearing of viewport for drawing purposes
	RenderingServer.viewport_set_clear_mode(get_viewport().get_viewport_rid(), RenderingServer.VIEWPORT_CLEAR_NEVER)	
	
	#set up buttons and their connection to respective function
	$Button.pressed.connect(self._on_button_pressed1)
	$save_button.pressed.connect(self._on_button_pressed)
	$pixel_size_button.pressed.connect(self._toggle_pixel_size_button_1x1)
	$pixel_size_button2.pressed.connect(self._toggle_pixel_size_button_2x2)
	$clear_button.pressed.connect(self._clear_image)

#function to swap between color and eraser
var c = 0
func _on_button_pressed1():
	if c % 2 == 0:
		color = "#000000"
	else:
		color = "#E6EEEF"
	c+=1

#save button logic 
func _on_button_pressed():
	print('Saving image...')
	var capture = get_viewport().get_texture()
	var image = capture.get_image()
	var final_image = image.get_region(Rect2i(0, 0, 64, 64))
	final_image.save_png("res://sample_image.png")
	Events.creature_created.emit()
	var culled: Image = Image.load_from_file("res://sample_image.png")
	var sprite = make_image_transparent_and_spritize("res://sample_image.png")
	print("done...")
	
var size = Vector2(1, 1)
var arr = [Vector2(1, 1), Vector2(2, 2)]
func _toggle_pixel_size_button_1x1():
	size = arr[0]
func _toggle_pixel_size_button_2x2():
	size = arr[1]

var clear = false
func _clear_image():
	clear = not clear
	queue_redraw()
	
func _draw() -> void:
	if clear == true:
		var rect = Rect2(Vector2.ZERO, Vector2(64, 64))
		draw_rect(rect, Color.BLACK)
		clear = false
		
	#get screen position, and if left click -> call draw_circle at current position
	var curr = get_local_mouse_position()
	var rect_with_position = Rect2(Vector2(curr[0], curr[1]), size)
	draw_rect(rect_with_position, color)
	
func make_image_transparent_and_spritize(path):
	var image = Image.load_from_file(path)
	image.convert(Image.FORMAT_RGBA8)
	
	#iterate through pixels
	for i in range(image.get_width()):
		for j in range(image.get_height()):
			#get current pixel
			var curr = image.get_pixel(i, j)
			#set opacity to our red pixel 
			#if rgb (0, 0, 0 == black), then we set opacity to 0
			curr.a = curr.r
			image.set_pixel(i, j, curr)
	image.save_png("res://creature" + str(Events.creature_count) + ".png")
	var texture = ImageTexture.create_from_image(image)
	
	var sprite = Sprite2D.new()
	sprite.texture = texture
	return sprite
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	if Input.is_action_pressed("left_click") and area_rect.has_point(mouse_pos):
		queue_redraw()


func _on_hub_button_button_up():
	Events.scene_change_requested.emit("res://Scenes/Hub.tscn")
	RenderingServer.viewport_set_clear_mode(get_viewport().get_viewport_rid(), RenderingServer.VIEWPORT_CLEAR_ALWAYS)
	get_window().content_scale_size = Vector2i(1920, 1200)
