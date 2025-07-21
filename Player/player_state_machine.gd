extends Node

@export var initital_state : State

var current_state : State
var states : Dictionary = {}

enum {IDLE, WALK, RUN, PICK}

var curAnim = IDLE

var blend_speed = 15

var idle_val : float = 0.0
var walk_val : float = 0.0
var run_val : float = 0.0
var pick_val : float = 0.0

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	
	if initital_state:
		initital_state.Enter()
		current_state = initital_state

func _process(delta: float) -> void:
	if current_state:
		current_state.Update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.Physics_Update(delta)

func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.Exit()
	
	new_state.Enter()
	
	current_state = new_state
