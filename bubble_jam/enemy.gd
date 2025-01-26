extends Area2D
@export var squirt_scene : PackedScene
signal hit
#var ball : CharacterBody2D
var screen_size

var initial_position : Vector2
var audio : AudioStreamPlayer2D
const squirt_speed = 500
@onready var enemy = $AnimatedSprite2D

var time_passed = 0.0  # Track the time passed
const shoot_interval = 0.5  # Shoot every 0.5 seconds

func _ready() -> void:
	audio = get_node("EnemyProjectile/squirtAudio")
	enemy.play()

func _process(delta: float) -> void:
	time_passed += delta
	if time_passed >= shoot_interval:
	#if Input.is_action_pressed("player_shoot"):
		shoot(enemy.position-Vector2(100,0),Vector2(1,0))
		time_passed = 0.0
		
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectile"):
		hit.emit()
		$CollisionShape2D.set_deferred("disabled", true)
		queue_free()
		
func shoot(enemy_pos: Vector2,dir:Vector2) -> void:
	var new_squirt = squirt_scene.instantiate()
	print("timerReset")
	new_squirt.position = enemy_pos
	call_deferred("add_child", new_squirt)
