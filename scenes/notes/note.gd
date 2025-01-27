extends Interactible3D

@export_multiline var text: String

@onready var note_ui = $Note
@onready var note_ui_label = $Note/TextureRect/RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	note_ui_label.text = text


func _on_interact() -> void:
	set_open(!note_ui.visible)
	
func set_open(open: bool):	
	if open:
		Engine.time_scale = 0
		$OpenSound.play()
		note_ui.visible = true
	else:
		Engine.time_scale = 1
		$CloseSound.play()
		note_ui.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if note_ui.visible:
		if Input.is_key_pressed(KEY_ESCAPE):
			note_ui.visible = false
			get_viewport().set_input_as_handled()
