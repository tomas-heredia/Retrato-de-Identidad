extends Node3D

@export var sensibilidad_mouse: float = 0.005
@export_range(-90.0,0.0,0.1, "radians_as_degreea") var min_vbertical_angle: float = - PI/2
@export_range(0.0,90.0,0.1, "radians_as_degreea") var max_vbertical_angle: float = PI/4

@onready var spring_arm = $SpringArm3D

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event : InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x * sensibilidad_mouse
		rotation.y = wrapf(rotation.y, 0.0, TAU)
		
		rotation.x -= event.relative.y * sensibilidad_mouse
		rotation.x = clamp(rotation.x, min_vbertical_angle,max_vbertical_angle)
		
	
