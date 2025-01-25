extends Area2D
signal hit
var screen_size
#var ball : CharacterBody2D
@onready var enemy = $AnimatedSprite2D

func _ready() -> void:
	#print(enemy.position)
	screen_size = get_viewport_rect().size
	#ball = get_parent().get_node("ball")

#func _physics_process(delta: float) -> void:
	#global_position.y  = ball.global_position.y


func _on_area_entered(area: Area2D) -> void:
	#hide() # Player disappears after being hit.
	# Must be deferred as we can't change physics properties on a physics callback.
	print("hit detected")
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	queue_free()

	print("+1")
	
	#await get_tree().create_timer(1.0).timeout
	#respawn()
#
