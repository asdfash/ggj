extends Area2D
signal hit
#var ball : CharacterBody2D
@onready var enemy = $AnimatedSprite2D

func _ready() -> void:
	enemy.play()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectile"):
		hit.emit()
		$CollisionShape2D.set_deferred("disabled", true)
		queue_free()
