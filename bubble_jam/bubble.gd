extends RigidBody2D
signal grow

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectile"):
		$Sprite2D.hide()
		$Area2D.hide()
		$CollisionShape2D.hide()
		$AnimatedSprite2D.play("bubble_pop")
		$AnimatedSprite2D.animation_finished.connect(queue_free)
		if not area.is_in_group("enemy"):
			grow.emit()
