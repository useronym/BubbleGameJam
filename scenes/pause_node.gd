extends Control

@onready var settingsPanel = $Settings
@onready var mainPanel = $Main



#region Main Panel

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action_pressed("ui_cancel"):
		match Input.mouse_mode:
			Input.MOUSE_MODE_CAPTURED:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
				Engine.time_scale = 0
				self.show()
			Input.MOUSE_MODE_VISIBLE:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
				Engine.time_scale = 1
				self.hide()


func _unpause() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Engine.time_scale = 1
	self.hide()

func _settings() -> void:
	mainPanel.hide()
	settingsPanel.show()

func _quit() -> void:
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://scenes/mainMenu.tscn")

func _actually_quit() -> void:
	get_tree().quit()

func _on_close_button() -> void:
	settingsPanel.hide()
	mainPanel.show() 


#endregion
