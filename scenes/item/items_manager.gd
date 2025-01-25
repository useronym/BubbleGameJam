extends Node3D

signal all_items_collected

var items_collected = 0

const TOTAL_ITEMS = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child.has_signal('item_collected'):
			child.item_collected.connect(_on_item_collected)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_item_collected():
	items_collected = items_collected + 1;
	if items_collected >= TOTAL_ITEMS:
		all_items_collected.emit()
