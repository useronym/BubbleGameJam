extends MeshInstance3D

@onready var light = $OmniLight3D
var noise = FastNoiseLite.new()

var time = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	noise.frequency = 0.5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	light.light_energy = 0.1 + 0.9*abs(noise.get_noise_1d(time))
