extends CharacterBody3D


@export var SPEED := 5.0
@export var Max_SPEED := 10
@export var aceleracion := 20
@export var desaceleracion := 0.2
@export var JUMP_VELOCITY := 8
@export var gravity := 9.8
var direction = Vector3(0,0,0)
@onready var stairs_colision = $StairsColision
@onready var modelo = $Modelo
@onready var interaccion_label = $Interaccion_label
@onready var camera = $SpringArmPivot/Camera3D
@onready var coyote_timer = $CoyoteTimer

var coyote_timer_activado := true
var interactuando_portal: bool = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var nombre_portal : String
var frenando := false
var doble_salto := false
func _ready():
	interaccion_label.hide()
	


func _physics_process(delta):
	if !Global.interactuando:
		movement(delta)


func movement(delta):
	if is_on_floor():
		coyote_timer_activado = true
		
		coyote_timer.stop()
		
	else:
		if coyote_timer.is_stopped():
			coyote_timer.start()
		velocity.y -= gravity * delta
		
		
		
	if Input.is_action_just_pressed("Jump") and doble_salto :
			velocity.y = JUMP_VELOCITY
			doble_salto = false
	if Input.is_action_just_pressed("Jump") and coyote_timer_activado:
		velocity.y = JUMP_VELOCITY
		coyote_timer_activado = false
		doble_salto = true
	
	var input_dir = Input.get_vector("Left", "Right", "Up", "Down")
	var cam_forward = -camera.global_transform.basis.z
	cam_forward.y = 0
	cam_forward = cam_forward.normalized()

	var cam_right =- camera.global_transform.basis.x
	cam_right.y = 0
	cam_right = cam_right.normalized()

	direction = (cam_right * input_dir.x + cam_forward * input_dir.y).normalized()
	#direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#
	#
	#direction =  direction.rotated(Vector3.UP, camera.global_rotation.y)
	if direction:
		frenando = false
		##playback.travel("run")
		#velocity.x = -direction.x * SPEED
		#velocity.z = -direction.z * SPEED
		
		# Calcula velocidad objetivo y acelera suavemente hacia ella
		var target_x = -direction.x * Max_SPEED
		var target_z = -direction.z * Max_SPEED

		velocity.x = move_toward(velocity.x, target_x, aceleracion * delta)
		velocity.z = move_toward(velocity.z, target_z, aceleracion * delta)
		rotar(direction)
		
		
		
	else:
		if not frenando:
			frenando = true
			#playback.travel("idle")
			#velocity.x = move_toward(velocity.x, 0, SPEED)
			#velocity.z = move_toward(velocity.z, 0, SPEED)
			var tween := create_tween()
			tween.tween_property(self, "velocity:x", 0.0, desaceleracion).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
			tween.tween_property(self, "velocity:z", 0.0, desaceleracion).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

			
	move_and_slide()
		
	#else :
		#velocity.x = 0
		#velocity.z = 0
		##playback.travel("idle")


func rotar(direction):
	
	var x = Vector2(direction.x,0)
	var z = Vector2(0,direction.z)
	
	var dir = x.angle_to_point(z)-1.5708
	
	stairs_colision.rotation.y = lerp_angle(modelo.rotation.y,dir,0.2)
	modelo.rotation.y = lerp_angle(modelo.rotation.y,dir,0.2)

func _unhandled_input(event):
	
	
	if event.is_action_pressed("Interact") and interactuando_portal and Global.puede_continuar:
		ManejoNiveles.cambiar(nombre_portal)

func _on_interaccion_body_entered(objeto):
	var grupo
	if objeto.get_groups().size() > 0:
		grupo = objeto.get_groups()[0]
		print(grupo)
		match grupo:
			"Portal":
				interactuando_portal = true
				interaccion_label.show()
				nombre_portal = objeto.name.replace("Portal_", "")
			"NPC":
				interactuando_portal = true
				interaccion_label.show()
			
			

func _on_interaccion_body_exited(objeto):
	var grupo
	if objeto.get_groups().size() > 0:
		grupo = objeto.get_groups()[0]
		match grupo:
			"Portal":
				interactuando_portal = false
				interaccion_label.hide()
			"NPC":
				interactuando_portal = false
				interaccion_label.hide()
			


func _on_coyote_timer_timeout():
	coyote_timer_activado = false
	
