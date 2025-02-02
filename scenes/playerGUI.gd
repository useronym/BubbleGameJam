extends CanvasLayer

@onready var label = $TextureRect/Label
@onready var air_capacity_bar = $AirProgressBar
@onready var debuginfo = $DebugInfoLabel
@onready var death_screen = $DeathScreen
const DEBUG_TEMPLATE = "PlayerState: {plrstate}\nPlayerSpeed: {speed}\nGlobal Coordinates (X/Y/Z): {globalpos}\nFPS: {fps}"

## Updates the hover text thing. Used internally for process_interact() in player.gd
## Why we don't edit the label directly? who cares man it's not that big of a deal, it's just +1 picosecond of process time
func update_text(text : String) -> void:
	label.text = text
	
func update_air_capacity_bar(air: int) -> void:
	air_capacity_bar.value = air

func _input(event) -> void:
	if event.is_action_pressed("debug"):
		debuginfo.visible = !debuginfo.visible
		debugLoop()
		
	

func debugLoop():
	while debuginfo.visible:
		debuginfo.text = DEBUG_TEMPLATE.format({
			"plrstate": GameManager.player.currentState,
			"speed": GameManager.player.SPEED,
			"globalpos": GameManager.player.global_position,
			"fps": Engine.get_frames_per_second()
		})
		await get_tree().create_timer(.5).timeout


func _on_player_air_capacity_updated(new_value: int):
	update_air_capacity_bar(new_value)


func _on_player_character_died() -> void:
	death_screen.visible = true


func _on_hide_objective_timeout() -> void:
	$Objective.visible = false
