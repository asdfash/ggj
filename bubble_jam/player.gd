extends Node2D

const player_speed = 500  # Speed of the player
var screen_size
var squirt : Area2D  # Reference to the squirt
@onready var player = $player
@onready var playerHitbox = $CollisionShape2D

func _ready():
	screen_size = get_viewport_rect().size  # Get screen size
	player.position = Vector2(screen_size.x/1.1, screen_size.y/2)
	set_process(true)
	squirt = get_node("PlayerProjectile")  # squirt is a sibling node of the player (adjust the path accordingly)
	squirt.position = Vector2(-5, -5)

func _process(delta: float) -> void:
	var move_vector = Vector2.ZERO
	
	# Handle player movement
	if Input.is_action_pressed("player_up"):
		move_vector.y = -player_speed
		$player.animation = "up"
		$player.play()
	elif Input.is_action_pressed("player_down"):
		move_vector.y = player_speed
		$player.animation = "up"
		$player.play()
	else:
		$player.stop()
		

	player.position += move_vector * delta  # Move player based on input
	playerHitbox.position = player.position

	# Ensure player stays within screen boundaries
	if player.position.y < 0:
		player.position.y = 0
	if player.position.y > screen_size.y:
		player.position.y = screen_size.y

	# Handle shooting
	if Input.is_action_just_pressed("ui_accept") and squirt.speed == 0:
		squirt.shoot(player.position-Vector2(100,0),Vector2(-1,0))  # Call shoot function of the squirt and pass the player's position
