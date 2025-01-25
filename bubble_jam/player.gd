extends RigidBody2D

const player_speed = 500  # Speed of the player
const squirt_speed = 500  # Speed of the squirt
var screen_size
@onready var player = $player
var squirt : Node2D  # Reference to the squirt
#var animated_sprite : AnimatedSprite2D

var squirt_audio : AudioStreamPlayer2D
var squirt_speed_current = 0  # Squirt's speed, starts at 0
var squirt_direction = Vector2(0, 0)  # Squirt's direction, no movement at the start

func _ready():
	screen_size = get_viewport_rect().size  # Get screen size
	player.position = Vector2(screen_size.x / 1.1, screen_size.y / 2)
	
	# Get references to the squirt and audio
	squirt = get_node("squirt") 
	squirt_audio = $squirtAudio  # Assuming the audio player is a sibling or child node of the player
	
	# Initialize squirt parameters
	squirt.position = Vector2(-5, -5)
	squirt_speed_current = 0
	squirt_direction = Vector2(0, 0)
	
	# Assuming AnimatedSprite2D is a child of the player node
	#animated_sprite = $player
	
	set_process(true)

func _process(delta: float) -> void:
	var move_vector = Vector2.ZERO
	
	# Handle player movement
	if Input.is_action_pressed("player_up"):
		move_vector.y = -player_speed
		$player.animation = "up"
		$player.play()
	elif Input.is_action_pressed("player_down"):
		move_vector.y = player_speed
		$player.animation = "down"
		$player.play()
	else:
		$player.stop()

	player.position += move_vector * delta  # Move player based on input

	# Ensure player stays within screen boundaries
	if player.position.y < 0:
		player.position.y = 0
	if player.position.y > screen_size.y:
		player.position.y = screen_size.y

	# Handle shooting
	if Input.is_action_just_pressed("ui_accept") and squirt_speed_current == 0:
		print("wow")
		shoot_squirt(player.position)  # Call shoot function and pass the player's position

	# Handle squirt movement
	if squirt_speed_current > 0:
		squirt.position += squirt_direction * squirt_speed * delta
	
	# Check if the squirt goes off-screen (left or right)
	if squirt.position.x < 0 or squirt.position.x > screen_size.x:
		reset_squirt()  # Reset squirt when it goes off-screen

# Function to shoot the squirt
func shoot_squirt(player_pos: Vector2) -> void:
	# Set the squirt's position to the player's position
	squirt.position = player_pos  # Set the squirt's position to the player
	# Start the squirt's movement
	squirt_speed_current = squirt_speed
	squirt_direction = Vector2(-1, 0)  # Squirt moves left when shot
	squirt_audio.play()  # Play squirt shooting sound

# Function to reset the squirt (e.g., when it goes off-screen)
func reset_squirt() -> void:
	# Reset squirt to player's position
	squirt.position = Vector2(-5, -5)  # Reset squirt out of bounds (it could be hidden)
	squirt_speed_current = 0  # Stop the squirt
	squirt_direction = Vector2(0, 0)  # Stop squirt movement
