extends CharacterBody2D

var speed = 800
var jump_force = -2500
var gravity = 5000

func _ready():
	add_to_group("player")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	var input_dir = Input.get_axis("ui_left", "ui_right")
	velocity.x = input_dir * speed
	
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_force
			
	move_and_slide()
