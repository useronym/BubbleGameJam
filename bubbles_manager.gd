extends Node3D

signal bubbles_breathed_in()


func _bubble_breathed_in():
	bubbles_breathed_in.emit()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child.has_signal('breathed_in'):
			child.breathed_in.connect(_bubble_breathed_in)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
