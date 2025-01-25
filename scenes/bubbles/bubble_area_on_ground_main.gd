extends Node3D

signal breathed_in()


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer3D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_bubble_breath_area_3d_body_entered(body):
	breathed_in.emit()
	$AudioStreamPlayer3D.stop()
	queue_free()
