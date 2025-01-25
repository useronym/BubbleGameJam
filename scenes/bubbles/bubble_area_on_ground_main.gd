extends Node3D

signal air_bubbles_breathed_in()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_bubble_breath_area_3d_area_entered(area):
	air_bubbles_breathed_in.emit()
