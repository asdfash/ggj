extends Node2D

const player_speed = 500  # Speed of the player
var screen_size
var initial_position : Vector2
var squirt : Area2D  # Reference to the squirt
@onready var player = $player
@onready var playerHitbox = $CollisionShape2D

func setup():
	screen_size = get_viewport_rect().size  # Get screen size
	initial_position = Vector2(screen_size.x/1.1, screen_size.y/2)
	player.position = initial_position
	squirt = get_node("PlayerProjectile")
	squirt.position = Vector2(-5, -5)

func _ready():
	setup()
	set_process(true)

func _process(delta: float) -> void:
	var move_vector = Vector2.ZERO
	
	# Handle player movement
	if visible:
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
	else:
		player.position = initial_position
		

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

func scale(player_scale:Vector2):
	$player.scale = player_scale
	$CollisionShape2D.scale = player_scale
	
