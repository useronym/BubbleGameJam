extends Interactible3D

@export_multiline var text: String

@onready var note_ui = $Note
@onready var note_ui_label = $Note/TextureRect/RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	note_ui_label.text = text

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_interact() -> void:
	Engine.time_scale = 0
	$OpenSound.play()
	note_ui.visible = true
