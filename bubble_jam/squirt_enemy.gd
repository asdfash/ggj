extends Area2D
var audio : AudioStreamPlayer2D
var speed
var direction

func _ready() -> void:
	audio = $squirtAudio
	speed = 500
	direction = Vector2(1, randf_range(-0.25, 0.25))

func _process(delta: float) -> void:
	if speed > 0:
		position += direction * speed * delta
	if position.x < 0 or position.x > get_viewport().size.x or position.y < 0 or position.y > get_viewport().size.y:
		pass

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	queue_free()
