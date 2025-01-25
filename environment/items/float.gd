extends Node3D

@onready var start_pos = global_position

@export var speed = 0.1
@export var range = 0.25

var time = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += speed*delta
	global_position = start_pos + Vector3(0, range * sin(time), 0)
