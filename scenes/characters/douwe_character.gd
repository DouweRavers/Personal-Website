class_name DouweCharacter extends CharacterBody3D

@export var walking_speed:float = 1.5

@onready var navigation:NavigationAgent3D = $NavigationAgent3D
@onready var animation:AnimationTree = $AnimationTree

var moving := false
var move_direction := Vector3.ZERO

# Public
func go_to_position(target_global_position: Vector3) -> void:
	moving = true
	navigation.target_position = target_global_position

# Events
func _process(delta: float) -> void:
	if moving:
		_calc_velocity(delta)
	else:
		velocity = Vector3.ZERO
	_set_animation()

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _on_navigation_finished() -> void:
	moving = false
	print("Arrived")

# Private
func _calc_velocity(delta:float) -> void:
	var dist := navigation.get_next_path_position() - global_position
	
	# direction 
	var new_dir := dist.normalized()
	if not move_direction.is_equal_approx(new_dir):
		move_direction = new_dir
		move_direction.y = 0
	
	# speed
	var speed := walking_speed if walking_speed < dist.length() else dist.length()
	
	# angle
	var projection := 1.0
	if not move_direction.is_equal_approx(-basis.z):
		var angle := move_direction.signed_angle_to(-basis.z, Vector3.UP)
		projection = absf(clampf(cos(angle),-1,0))
		rotation.y += lerpf(0,clampf(angle,-1,1),delta*2)

	velocity = move_direction * speed * projection
	
func _set_animation()->void:
	var moving := walking_speed/5 < velocity.length()
	animation.set("parameters/conditions/idle", not moving)
	animation.set("parameters/conditions/walking", moving)
