class_name PlayerCharacter
extends CharacterBody3D

enum CharacterState {
	WALKING = 0,
}

signal air_capacity_updated(new_value)
signal character_died()

# All of the actually important stuff
@onready var head := $head
@onready var plrGUI := $PlayerGUI
@onready var InteractRaycast := $head/RayCast3D
@onready var camera := $head/Camera3D
@onready var animator := $AnimationPlayer
var currentBody : Interactible3D = null
var currentState : CharacterState = CharacterState.WALKING
@onready var SPEED = DEFAULT_SPEED # DEFAULT_SPEED doesn't load until _ready(), so we have to use @onready (you could also just move SPEED a bit to the bottom)

@onready var airDepletionTimer = $AirDepletionTimer
# Options
@export var DEFAULT_SPEED := 1
@export var mouse_sensitivity := 0.1

var CURRENT_AIR_CAPACITY := 100
const JESUS_PULLING_SPEED = 1.0

const MAX_AIR_CAPACITY := 100
const MIN_AIR_CAPACITY := 0
const DECREMENT_AIR_CAPACITY_VALUE_SECOND = 2.5
const INCREMENT_AIR_CAPACITY_VALUE = 50

var is_accending = false
var is_moving_to_the_beam_center = false
var lift_center = Vector3()
var inputEnabled := true # can the player move?

var aimlookEnabled := true # can the player look around?
var interactionsEnabled := true # can the player interact with Interactibles3D?
#region Main control flow 

func _ready():
	$MeshInstance3D.hide()
	%EndingArea.ending_started.connect(_on_ending_started)
	
	airDepletionTimer.start()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	GameManager.player = self
	update_air_capacity(self.CURRENT_AIR_CAPACITY)

func _physics_process(delta: float) -> void:
	if is_moving_to_the_beam_center:
		if global_position.distance_to(lift_center) < 0.2:
			is_moving_to_the_beam_center = false
			is_accending = true
		else:
			global_position = global_position.lerp(lift_center, 1.0 * delta)
	if is_accending: 
			position.y += JESUS_PULLING_SPEED * delta
	if !inputEnabled:
		return
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if not $WalkingAudio.playing:
			$WalkingAudio.play()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED) 
		if $WalkingAudio.playing:
			$WalkingAudio.stop()
	
	# All of the other processing functions go here
	_process_interact()
	_handle_states()
	
	move_and_slide()

#endregion

#region Processing input

func _process_interact():
	if !interactionsEnabled:
		return
	if not InteractRaycast.is_colliding():
		plrGUI.update_text("")
		return
	var collider = InteractRaycast.get_collider()
	if not collider is Interactible3D:
		plrGUI.update_text("")
		return
	if collider == currentBody and not Input.is_action_just_pressed("interact"): # This is a bit hacky imo, but works
		plrGUI.update_text(currentBody.InteractText)
		return
	
	currentBody = collider
	plrGUI.update_text(currentBody.InteractText)
	if Input.is_action_just_pressed("interact") && currentBody.CanInteract:
		currentBody.OnInteract.emit()

# Handles the mouse 🐁🐁🐁🐁🐁🐁🐁🐁
func _unhandled_input(event : InputEvent):
	if !aimlookEnabled:
		return
	
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		var mouseInput : Vector2
		mouseInput.x += event.relative.x
		mouseInput.y += event.relative.y
		self.rotation_degrees.y -= mouseInput.x * mouse_sensitivity
		head.rotation_degrees.x -= mouseInput.y * mouse_sensitivity

#endregion

#region Processing Character States

## Handles the input for character state changing. 
func _handle_states():
	if currentState != CharacterState.WALKING:
		change_state(CharacterState.WALKING)

## Handles the state changing itself. This function must be fired only once, and not run every single frame. 
func change_state(state : CharacterState):
	SPEED = DEFAULT_SPEED
	currentState = state


func increase_air_capacity(): 
	var new_air_capacity = self.CURRENT_AIR_CAPACITY + self.INCREMENT_AIR_CAPACITY_VALUE
	if new_air_capacity > self.MAX_AIR_CAPACITY:
		# TOO MUCH AIR
		new_air_capacity = self.MAX_AIR_CAPACITY
	update_air_capacity(new_air_capacity)


func decrease_air_capacity():
	var new_air_capacity = self.CURRENT_AIR_CAPACITY - self.DECREMENT_AIR_CAPACITY_VALUE_SECOND
	if new_air_capacity < self.MIN_AIR_CAPACITY:
		# DEATH
		player_death()
		$AirDepletionTimer.stop()
		new_air_capacity = self.MIN_AIR_CAPACITY
	update_air_capacity(new_air_capacity)

func update_air_capacity(newValue: int) -> void:
	self.CURRENT_AIR_CAPACITY = newValue
	air_capacity_updated.emit(newValue)
	
func player_death():
	character_died.emit()
	$DeathSound.play()
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_file("res://main.tscn")

func _on_air_depletion_timer_timeout():
	decrease_air_capacity()
	


func _on_bubble_manager_bubbles_breathed_in():
	airDepletionTimer.start()
	increase_air_capacity()
	pass # Replace with function body.

func _on_ending_started(center):
	#position.x = center.x
	#position.y = center.y
	lift_center = center
	is_moving_to_the_beam_center = true
	inputEnabled = false

#endregion
