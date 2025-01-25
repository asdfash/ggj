extends Node2D

const player_speed = 500  # Speed of the player
var screen_size
var squirt : Node2D  # Reference to the squirt

func _ready():
	screen_size = get_viewport_rect().size  # Get screen size
	position = Vector2(screen_size.x/1.1, screen_size.y/2)
	set_process(true)
	squirt = get_node("../squirt")  # squirt is a sibling node of the player (adjust the path accordingly)
	squirt.position = Vector2(-5, -5)

func _process(delta: float) -> void:
	var move_vector = Vector2.ZERO
	
	# Handle player movement
	if Input.is_action_pressed("player_up"):
		move_vector.y = -player_speed
	if Input.is_action_pressed("player_down"):
		move_vector.y = player_speed

	position += move_vector * delta  # Move player based on input

	# Ensure player stays within screen boundaries
	if position.y < 0:
		position.y = 0
	if position.y > screen_size.y:
		position.y = screen_size.y

	# Handle shooting
	if Input.is_action_just_pressed("ui_accept") and squirt.speed == 0:
		squirt.shoot(position)  # Call shoot function of the squirt and pass the player's position
