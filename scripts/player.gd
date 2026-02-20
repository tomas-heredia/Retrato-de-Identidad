extends CharacterBody3D

@export var max_vida := 100

var vida := 100:
	set(value):
		vida = clamp(value, 0, max_vida)
		actualizar_barra()

@export var SPEED := 5.0
@export var Max_SPEED := 10
@export var aceleracion := 20
@export var desaceleracion := 0.2
@export var JUMP_VELOCITY := 8
@export var gravity := 9.8
@export var invulnerabilidad_time := 1
var direction = Vector3(0,0,0)

@onready var invulnerable_timer: Timer = $invulnerable_timer
@onready var stairs_ahead = $StairsAhead
@onready var stairs_below = $StairsBehaind
@onready var tukuy = $tukuy_2
@onready var animation_tree = $tukuy_2/AnimationTree
var animation : AnimationNodeStateMachinePlayback

@onready var interaccion_label = $Interaccion_label
@onready var camera = $SpringArmPivot/Camera3D
@onready var coyote_timer = $CoyoteTimer
@onready var BarraVida: ProgressBar = $BarraVida

var es_invulnerable := false
var coyote_timer_activado := true
var interactuando_portal: bool = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var nombre_portal : String
var frenando := false
var doble_salto := false

const MAX_STEP_HEIGHT = 0.5
var _snapped_to_stairs_last_frame := false
var _last_frame_was_on_floor = -INF

func _ready():
	invulnerable_timer.wait_time = invulnerabilidad_time
	BarraVida.max_value = max_vida
	actualizar_barra()
	animation = animation_tree.get("parameters/playback")
	interaccion_label.hide()
	


func _physics_process(delta):
	if !Global.interactuando:
		movement(delta)


func movement(delta):
	if is_on_floor() or _snapped_to_stairs_last_frame:
		_last_frame_was_on_floor = Engine.get_physics_frames()
		coyote_timer_activado = true
		
		coyote_timer.stop()
		
	else:
		if coyote_timer.is_stopped():
			coyote_timer.start()
		velocity.y -= gravity * delta
		
	if Input.is_action_just_pressed("Restart"):
		position = Global.ultimoCheckPoint
		vida = 100
	
	if Input.is_action_just_pressed("Jump") and doble_salto :
		animation.travel("doublejump")
		#animation.travel("doublejump")
		velocity.y = JUMP_VELOCITY
		doble_salto = false
	
	if Input.is_action_just_pressed("Jump") and coyote_timer_activado:
		animation.travel("simplejump")
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
		await get_tree().physics_frame
		if is_on_floor() :
			animation.travel("run")
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
		if animation.get_current_node() != "idle" and is_on_floor():
			animation.travel("idle")
		velocity.x = move_toward(velocity.x, 0.0, aceleracion * delta)
		velocity.z = move_toward(velocity.z, 0.0, aceleracion * delta)
	if not _snap_up_to_stairs_check(delta):
		move_and_slide()
		_snap_down_to_stairs_check()
			
	#else :
		#velocity.x = 0
		#velocity.z = 0
		##playback.travel("idle")


func rotar(direction):
	
	var x = Vector2(direction.x,0)
	var z = Vector2(0,direction.z)
	
	var dir = x.angle_to_point(z)-1.5708
	
	stairs_ahead.rotation.y = lerp_angle(tukuy.rotation.y,dir,0.2)
	tukuy.rotation.y = lerp_angle(tukuy.rotation.y,dir + PI/2,0.2)

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
	
func is_surface_to_steep(normal : Vector3):
	return normal.angle_to(Vector3.UP) > self.floor_max_angle

func _run_body_test_motion(from : Transform3D, motion : Vector3, result = null):
	if not result : result = PhysicsTestMotionResult3D.new()
	var parameters = PhysicsTestMotionParameters3D.new()
	parameters.from = from
	parameters.motion = motion
	return PhysicsServer3D.body_test_motion(self.get_rid(),parameters,result)
	
func _snap_down_to_stairs_check():
	var did_snap := false
	var floor_below :bool = stairs_below.is_colliding() and  not is_surface_to_steep(stairs_below.get_collision_normal())
	var was_on_floor_last_frame = Engine.get_physics_frames() - _last_frame_was_on_floor == 1
	
	if not is_on_floor() and velocity.y <= 0 and (was_on_floor_last_frame or _snapped_to_stairs_last_frame) and floor_below:
		var body_test_result = PhysicsTestMotionResult3D.new()
		if _run_body_test_motion(self.global_transform, Vector3(0,MAX_STEP_HEIGHT,0), body_test_result):
			var translate_y = body_test_result.get_travel().y
			self.position.y += translate_y
			apply_floor_snap()
			did_snap = true
	_snapped_to_stairs_last_frame = did_snap
	

func _snap_up_to_stairs_check(delta):
	if not is_on_floor() and not _snapped_to_stairs_last_frame: return false
	var expected_move_motion = self.velocity * Vector3(1,0,1) * delta
	var step_pos_with_clearance = self.global_transform.translated(expected_move_motion + Vector3(0,MAX_STEP_HEIGHT*2,0))
	var down_check_result = PhysicsTestMotionResult3D.new()
	
	if(_run_body_test_motion(step_pos_with_clearance, Vector3(0,-MAX_STEP_HEIGHT*2,0), down_check_result)
	and (down_check_result.get_collider().is_class("StaticBody3D") or down_check_result.get_collider().is_class("CSGShape3D"))):
		
		var step_height = ((step_pos_with_clearance.origin + down_check_result.get_travel()) - self.global_position).y
		if step_height > MAX_STEP_HEIGHT or step_height <= 0.01 or (down_check_result.get_collision_point() - self.global_position).y > MAX_STEP_HEIGHT: return false
		
		stairs_ahead.global_position = down_check_result.get_collision_point() + Vector3(0,MAX_STEP_HEIGHT,0) + expected_move_motion.normalized()*0.1
		stairs_ahead.force_raycast_update()
		
		if stairs_ahead.is_colliding() and not is_surface_to_steep(stairs_ahead.get_collision_normal()):
			
			self.global_position = step_pos_with_clearance.origin + down_check_result.get_travel()
			apply_floor_snap()
			_snapped_to_stairs_last_frame = true
			return true
	return false

func actualizar_barra():
	BarraVida.value = vida

func recibir_daño(valor: int):
	if !es_invulnerable:
		activar_invulnerabilidad()
		vida -= valor
		if vida == 0:
			velocity = Vector3.ZERO
			position = Global.ultimoCheckPoint
			vida = 100

func activar_invulnerabilidad():
	
	es_invulnerable = true
	invulnerable_timer.start()


func _on_invulnerable_timer_timeout() -> void:
	es_invulnerable = false
