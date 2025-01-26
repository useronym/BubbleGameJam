extends Node3D

signal all_items_collected

var items_collected = 0

const TOTAL_ITEMS = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		var area3d = child.get_child(0)
		if area3d.has_signal('item_collected'):
			area3d.item_collected.connect(_on_item_collected)

func turn_off_the_sounds():
	for child in %Audio.get_children():
		child.stop()

func _on_item_collected():
	items_collected = items_collected + 1;
	if items_collected >= TOTAL_ITEMS:
		%EndingModels.visible = true
		turn_off_the_sounds()
		all_items_collected.emit()
