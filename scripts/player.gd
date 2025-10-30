extends CharacterBody3D


@export var SPEED = 5.0
var direction = Vector3(0,0,0)
const JUMP_VELOCITY = 4.5
@onready var stairs_colision = $StairsColision
@onready var modelo = $Modelo
@onready var interaccion_label = $Interaccion_label

var interactuando_portal: bool = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var nombre_portal : String

func _ready():
	interaccion_label.hide()


func _physics_process(delta):
	if !Global.interactuando:
		movement(delta)


func movement(delta):
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	
	
	var input_dir = Input.get_vector("Left", "Right", "Up", "Down")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	
	if direction:
		
		#playback.travel("run")
		velocity.x = -direction.x * SPEED
		velocity.z = -direction.z * SPEED
		rotar(direction)
		
		
		
	else:
			
		#playback.travel("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
			
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
	
	
	if event.is_action_pressed("Interact") and interactuando_portal:
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
