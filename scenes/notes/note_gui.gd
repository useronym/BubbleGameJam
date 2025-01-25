extends Control

var released_e = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if visible:
		if Input.is_action_just_released("interact"):
			released_e = true
		if released_e && Input.is_key_pressed(KEY_E):
			$CloseSound.play()
			Engine.time_scale = 1
			visible = false
			released_e = false
