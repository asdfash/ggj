extends CharacterBody2D

const SPEED := 16000.0

func getYDir() -> float:
	return Input.get_action_strength("player_down") - Input.get_action_strength("player_up")

func _physics_process(delta: float) -> void:
	var dir :Vector2=Vector2(0, getYDir())
	velocity = dir * SPEED * delta
	move_and_slide()
