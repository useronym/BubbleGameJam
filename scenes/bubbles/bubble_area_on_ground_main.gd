extends Node3D

signal breathed_in()

@onready var bubble_vfx = $BubbleSprite
@onready var bubble_particles = $BubbleSprite/GPUParticles3D
@onready var respawn_timer = $RespawnTimer

var active = true

const RESPAWN_TIME = 30


# Called when the node enters the scene tree for the first time.
func _ready():
	# respawn_timer.TimerProcessCallback
	$AudioStreamPlayer3D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_bubble_breath_area_3d_body_entered(body):
	if (!active):
		return
		
	breathed_in.emit()
	$AudioStreamPlayer3D.stop()
	bubble_vfx.visible = false
	active = false
	respawn_timer.start(RESPAWN_TIME)


func _on_respawn_timer_timeout() -> void:
	bubble_vfx.visible = true
	active = true
	$AudioStreamPlayer3D.play()
