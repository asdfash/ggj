extends Area2D
signal hit
#var ball : CharacterBody2D

#func _ready() -> void:
	#ball = get_parent().get_node("ball")

#func _physics_process(delta: float) -> void:
	#global_position.y  = ball.global_position.y

func _on_body_entered(_body: Node2D) -> void:
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
	print("+1")
