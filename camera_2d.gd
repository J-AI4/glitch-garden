extends Camera2D

var camera_speed = 300.0
var min_bottom_y = 0.0
var max_y = 999999.0

func _process(delta):
	var movement = 0.0
	
	if Input.is_action_pressed("camera_up"):
		movement -= camera_speed * delta
	if Input.is_action_pressed("camera_down"):
		movement += camera_speed * delta
		
	var half_height = (get_viewport_rect().size.y * zoom.y) / 2.0
	
	var min_camera_y = min_bottom_y - half_height
		
	position.y = clamp(position.y + movement, min_camera_y, max_y)
	
	
	
	
														  
							   
