extends Interactible3D

@onready var note_ui = $Note

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interact() -> void:
	Engine.time_scale = 0
	$OpenSound.play()
	note_ui.visible = true
