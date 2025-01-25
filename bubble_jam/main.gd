extends Node

@export var bubble_scene: PackedScene
@export var enemy_scene: PackedScene

var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#new_game()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func new_game():
	get_tree().call_group("bubbles", "queue_free")
	score = 0
	$StartTimer.start()
	#$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	
func game_over():
	$BubbleSpawnTimer.stop()
	$HUD.show_game_over()
	
func _on_start_timer_timeout() -> void:
	$BubbleSpawnTimer.start()
	#$HUD.update_score(score)
	
func _on_bubble_spawn_timer_timeout() -> void:
	# Create a new instance of the Bubble scene.
	var bubble = bubble_scene.instantiate()
	
	# Choose a random location on BubblePath.
	var bubble_spawn_location = $BubblePath/BubbleSpawnLocation
	bubble_spawn_location.progress_ratio = randf()
	
	# Set the bubble's direction perpendicular to the path direction.
	var direction = bubble_spawn_location.rotation + PI / 2
	
	# Set the bubble's position to a random location
	bubble.position = bubble_spawn_location.position
	
	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	bubble.rotation = direction
	
	# Choose the velocity for the bubble.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	bubble.linear_velocity = velocity.rotated(direction)
	
	# Spawn the bubble by adding it to the Main scene.
	add_child(bubble)


func _on_enemy_hit() -> void:
	print("hit signal received")
	$EnemySpawnTimer.start()


func _on_enemy_spawn_timer_timeout() -> void:
	print("on enemy hit is called")
	#get_node("Enemy/CollisionShape2D").set_deferred("disabled", false)
	#get_node("Enemy").show()
	#queue_free()
	#print("queue freed")
		# Create a new instance of the Bubble scene.
	var enemy = enemy_scene.instantiate()
	print("craeted after queue freed")
	
	enemy.get_node("CollisionShape2D").disabled = false
	print("disabled")
	
	#enemy.get_node("CollisionShape2D").set_deferred("disabled", false)
	
	# Choose a random location on BubblePath.
	var enemy_spawn_location = $EnemyPath/EnemySpawnLocation
	enemy_spawn_location.progress_ratio = randf_range(0.4, 0.6)
	
	# Set the bubble's position to a random location
	enemy.position = enemy_spawn_location.position

	add_child(enemy)
	print("does it stop here")
	
	# Enable this for continuous run to debug
	#$EnemySpawnTimer.stop()
