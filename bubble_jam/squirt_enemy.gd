extends Area2D
var audio : AudioStreamPlayer2D
var speed
var direction
const squirt_speed = 500
#var isReady = false

func _ready() -> void:
	audio = $squirtAudio
	speed = 500
	direction = Vector2(1, randf_range(-0.1, 0.1))

func _process(delta: float) -> void:
	if speed > 0:
		position += direction * squirt_speed * delta
	if position.x < 0 or position.x > get_viewport().size.x or position.y < 0 or position.y > get_viewport().size.y:
		#reset_squirt()
		#queue_free()
		pass

#func _on_area_entered(area: Area2D) -> void:
	#if area.is_in_group("projectile"):
		##reset_squirt();
		#queue_free()		
		
#func set_direction_and_speed(new_direction: Vector2, new_speed: float) -> void:
	#direction = new_direction
	#speed = new_speed  # Make sure speed is properly assigned
	#isReady = true
		
#func shoot(enemy_pos: Vector2,dir:Vector2) -> void:
	#var new_squirt = squirt_scene.instantiate()
	#new_squirt.position = enemy_pos
	#new_squirt.speed = squirt_speed
	#new_squirt.direction = dir
	#add_child(new_squirt)
	#new_squirt.set_process(true)
	#audio.play()
#
#func reset_squirt() -> void:
	#queue_free()
	#speed = 0 
	#direction = Vector2(0, 0)
	#set_process(false)
	
