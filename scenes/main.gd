extends Node3D

@onready var douwe:DouweCharacter = $Douwe
@onready var cilinder_position:Marker3D = $World/cilinder/WalkPosition
@onready var block_position:Marker3D = $World/block/WalkPosition

func _ready() -> void:
	douwe.go_to_position(Vector3.ZERO)
	#var console = JavaScriptBridge.get_interface("console")
	#console.log("hello world!")

func _on_cilinder_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		var mouseButtonEvent := event as InputEventMouseButton
		if mouseButtonEvent.button_index == MOUSE_BUTTON_LEFT:
			douwe.go_to_position(cilinder_position.global_position)

func _on_block_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		var mouseButtonEvent := event as InputEventMouseButton
		if mouseButtonEvent.button_index == MOUSE_BUTTON_LEFT:
			douwe.go_to_position(block_position.global_position)
