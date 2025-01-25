extends Interactible3D

signal item_collected

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_on_interact() -> void:
	$PickupSound.play()
	item_collected.emit()
	$CollisionShape3D.free()
	pass
