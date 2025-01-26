extends Node3D

signal ending_started

@onready var area_3d = $EndingTriggerArea
@onready var lift = $LiftToJesus

var is_ending_in_progress = false
const JESUS_PULL_SPEED = 0.3

# Called when the node enters the scene tree for the first time.
func _ready():
	%ItemsManager.all_items_collected.connect(_on_all_items_collected)
	area_3d.body_entered.connect(_on_area_3d_entered_by_player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if is_ending_in_progress:
		# LIFTING
		lift.global_transform.origin.y += JESUS_PULL_SPEED * delta
	

func _on_all_items_collected():
	area_3d.monitoring = true

func enable_lift():
	$LiftToJesus/CollisionShape3D.disabled = false
	
# ENDING
func _on_area_3d_entered_by_player():
	ending_started.emit()
	enable_lift()
	
	is_ending_in_progress = true
