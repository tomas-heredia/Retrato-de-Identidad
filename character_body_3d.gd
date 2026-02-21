extends CharacterBody3D
@export var mouse_sensitivity := 0.002
@onready var cam = $Camera3D


var rotation_x := 0.0
var activado := false

const min_speed = 1.0
const max_speed = 25.0
var SPEED = 5.0
func _ready():
	self.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _input(event):
	if event.is_action_pressed("camara_libre"):
		activado = !activado
		Global.interactuando = activado
		if activado:
			Mensajero.Cambio_Camara.emit(cam)
		else:
			SPEED = 5
			position = Vector3.ZERO
			Mensajero.regresar_camara.emit()
	
	if event.is_action_pressed("wheel_up") and activado:
		SPEED = min(SPEED + 1, max_speed)

	if event.is_action_pressed("wheel_down") and activado:
		SPEED = max(SPEED - 1, min_speed)
	
	if event is InputEventMouseMotion and activado:
		# Rotación horizontal (cuerpo)
		rotate_y(-event.relative.x * mouse_sensitivity)

		# Rotación vertical (solo cámara)
		rotation_x -= event.relative.y * mouse_sensitivity
		rotation_x = clamp(rotation_x, deg_to_rad(-80), deg_to_rad(80))
		cam.rotation.x = rotation_x

	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta: float) -> void:
	if not activado:
		return

	var direction := Vector3.ZERO
	
	# Base de la cámara (rotación completa)
	var cam_basis = cam.global_transform.basis
	
	# Movimiento horizontal
	var input_dir := Input.get_vector("Left", "Right", "Up", "Down")
	
	direction += cam_basis.x * input_dir.x
	direction -= -cam_basis.z * input_dir.y
	
	# Movimiento vertical libre
	if Input.is_action_pressed("Jump"):
		direction += cam_basis.y
	elif Input.is_action_pressed("descender"):
		direction += -cam_basis.y
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
	
	velocity = direction * SPEED
	
	move_and_slide()
