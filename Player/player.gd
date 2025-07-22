extends CharacterBody3D

@export_group("Camera")
@export_range(0.0, 0.1) var mouse_sensitivity := 0.25

@export_group("Movement")
@export var move_speed := 8.0
@export var acceleration := 20.0
@export var rotation_speed := 12.0
@export var jump_impluse := 12.0

var _camera_zoom_offset: float = 0.0
var _camera_zoom_offset_buffer: float = 0.0

var _cancel_movement = false

var _camera_input_direction := Vector2.ZERO
var _last_movement_direction := Vector3.BACK
var _gravity := -30.0

var _old_mouse_pos : Vector2

@onready var _camera_pivot: Node3D = $CameraPivot
@onready var _camera_spring: Node3D = $CameraPivot/SpringArm3D
@onready var _camera: Camera3D = $CameraPivot/SpringArm3D/Camera3D
@onready var _skin := $CodeCraftMainMC

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("right mouse click"):
		_old_mouse_pos = get_viewport().get_mouse_position()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action_released("right mouse click"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_viewport().warp_mouse(_old_mouse_pos)
	if event.is_action_pressed("scroll up"): _camera_zoom_offset_buffer -= 3
	if event.is_action_pressed("scroll down"): _camera_zoom_offset_buffer += 3
	
	

func _unhandled_input(event: InputEvent) -> void:
	var is_camera_motion := (
		event is InputEventMouseMotion and
		Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	)
	
	if is_camera_motion:
		_camera_input_direction = event.screen_relative * mouse_sensitivity

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	_camera_zoom_offset = lerpf(_camera_zoom_offset, _camera_zoom_offset_buffer, 0.1)
	
	_camera_spring.spring_length += _camera_zoom_offset
	_camera_spring.spring_length = clamp(_camera_spring.spring_length, 0.0, 30.0)
	_camera_zoom_offset_buffer = 0.0


func _physics_process(delta: float) -> void:
	_camera_pivot.rotation.x += _camera_input_direction.y * delta
	_camera_pivot.rotation.x = clamp(_camera_pivot.rotation.x, -PI / 6.0, PI / 3.0)
	_camera_pivot.rotation.y -= _camera_input_direction.x * delta
	
	_camera_input_direction = Vector2.ZERO
	
	var raw_input := Input.get_vector("a", "d", "w", "s")
	if _cancel_movement:
		raw_input = Vector2.ZERO
	var forward := _camera.global_basis.z
	var right := _camera.global_basis.x
	var move_direction := forward * raw_input.y + right * raw_input.x
	move_direction.y = 0.0
	move_direction = move_direction.normalized()
	
	var y_velocity := velocity.y
	velocity.y = 0.0
	
	velocity = velocity.move_toward(move_direction * move_speed, acceleration * delta)
	velocity.y = y_velocity + _gravity * delta
	 
	var is_starting_jump := Input.is_action_just_pressed("space") and is_on_floor()
	if is_starting_jump:
		velocity.y += jump_impluse
	
	if not _cancel_movement:
		move_and_slide()
	
	if move_direction.length() > 0.2:
		_last_movement_direction = move_direction
	
	var target_angle := Vector3.BACK.signed_angle_to(_last_movement_direction, Vector3.UP)
	_skin.global_rotation.y = lerp_angle(_skin.rotation.y, target_angle, rotation_speed * delta)
	
	var ground_speed := velocity.length()

	
