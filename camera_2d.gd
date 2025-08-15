extends Camera2D

var camera_speed = 600.0
var min_bottom_y = -1000.0

func _process(delta):
	var movement = 0.0
	
	if Input.is_action_pressed("camera_up"):
		movement -= camera_speed * delta
	if Input.is_action_pressed("camera_down"):
		movement += camera_speed * delta
		
	var half_height = (get_viewport_rect().size.y * zoom.y) / 2.0
	
	var lowest_y = min_bottom_y + half_height
		
	position.y = clamp(position.y + movement, -INF, lowest_y)
	
func _ready():
	var camera_width = get_viewport_rect().size.x * zoom.x
	var camera_height = get_viewport_rect().size.y * zoom.y
	print("Camera Width:", camera_width, "Camera Height:", camera_height)
