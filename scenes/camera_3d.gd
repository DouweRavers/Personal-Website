extends Camera3D

@export var mouse_speed : float = 1.0
@export var touch_speed : float = 1.0

var _input_motion : Vector2

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var motion_event := event as InputEventMouseMotion
		_input_motion = -motion_event.relative * mouse_speed

		
	if event is InputEventScreenDrag:
		var touch_event := event as InputEventScreenDrag
		_input_motion = -touch_event.relative * touch_speed


func _process(delta: float) -> void:
	rotate_y(_input_motion.x * delta)
	rotate_x(_input_motion.y * delta)
	rotation.z = 0
	_input_motion = Vector2.ZERO
