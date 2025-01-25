extends SubViewportContainer

@onready var subviewport = $SubViewport

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().get_root().size_changed.connect(_on_resized) 
	_on_resized()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_resized() -> void:
	size = get_viewport().size
