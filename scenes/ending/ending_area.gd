extends Node3D

signal ending_started(lift_center)

@onready var area_3d = $EndingTriggerArea

# Called when the node enters the scene tree for the first time.
func _ready():
	%ItemsManager.all_items_collected.connect(_on_all_items_collected)

func _on_all_items_collected():
	$beamLight.visible = true
	area_3d.monitoring = true
	
func _on_ending_trigger_area_body_entered(body):
	ending_started.emit(area_3d.global_position)
