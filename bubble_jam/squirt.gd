extends Node2D

var audio : AudioStreamPlayer2D
var speed = 0  # squirt's speed, starts at 0
var direction = Vector2(0, 0)  # squirt's direction, no movement at the start
const squirt_speed = 500  # Constant for the squirt speed

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	# Initialize the speed and direction
	audio = $squirtAudio
	speed = 0
	direction = Vector2(0, 0)
	set_process(false)  # The squirt won't move until it is shot

# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta: float) -> void:
	# Move the squirt based on its speed and direction
	if speed > 0:
		position += direction * speed * delta
	# Check if the squirt goes off-screen (left or right)
	if position.x < 0 or position.x > get_viewport().size.x:
		reset_squirt()  # Reset squirt when it goes off-screen

# Function to shoot the squirt
func shoot(player_pos: Vector2) -> void:
	# Set the squirt's position to the player's position
	position = player_pos  # Set the squirt's position to the player
	# Start the squirt's movement
	speed = squirt_speed
	direction = Vector2(-1, 0)  # squirt moves left when shot
	set_process(true)  # Start processing to move the squirt
	audio.play()

# Function to reset the squirt (e.g., when it goes off-screen)
func reset_squirt() -> void:
	# Reset squirt to player's position
	position = Vector2(-5, -5)  # Reset squirt out of bounds (maybe cahnge to not render)
	speed = 0  # Stop the squirt
	direction = Vector2(0, 0)  # Stop squirt movement
	set_process(false)  # Stop processing until the squirt is shot again
