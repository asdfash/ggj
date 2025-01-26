extends Area2D
signal hit

const player_speed = 500  # Speed of the player
var screen_size
var time_passed
const SHOOT_INTERVAL= 2
var initial_position : Vector2
var squirt : Area2D  # Reference to the squirt
@onready var player = $player
@onready var playerHitbox = $CollisionPolygon2D
@export var squirt_scene : PackedScene

func setup():
	screen_size = get_viewport_rect().size  # Get screen size
	initial_position = Vector2(screen_size.x/1.1, screen_size.y/2)
	time_passed = SHOOT_INTERVAL
	player.position = initial_position

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
	if time_passed < SHOOT_INTERVAL:
		time_passed += delta
	elif Input.is_action_just_pressed("ui_accept"):
		time_passed =0.0
		shoot(player.position-Vector2(100,0))

func scale(player_scale:Vector2):
	$player.scale = player_scale
	$CollisionPolygon2D.scale = player_scale
	

func _on_area_entered(area: Area2D) -> void:
	print(area)
	if area.is_in_group("projectile") and area.is_in_group("enemy"):
		hit.emit()

func shoot(shot_pos) -> void:
	var new_squirt = squirt_scene.instantiate()
	new_squirt.position = shot_pos
	call_deferred("add_child", new_squirt)
