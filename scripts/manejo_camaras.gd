extends Node3D
@onready var camera_transicion = $Camera_transicion

@export var camara_Player :Camera3D

var camara_actual
var TransitionTween: Tween
var TransitionZoomTween: Tween
var Transition0ffsetTween: Tween
# Called when the node enters the scene tree for the first time.
func _ready():
	camara_actual = camara_Player
	Mensajero.connect("Cambio_Camara",cambio_camara)
	Mensajero.connect("regresar_camara",regresar_camara)
	if camara_actual == null:
		print("Falta la camara actual")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func cambio_camara(camara_objetivo: Camera3D):
	camara_actual.current = false
	camera_transicion.current = true
	#seteando valores
	camera_transicion.global_transform = camara_actual.global_transform
	
	
	if TransitionTween:
		TransitionTween.kill()
	TransitionTween = create_tween()
	var target_transform = camara_objetivo.global_transform
	TransitionTween.tween_property(camera_transicion,"global_transform",target_transform,0.5).set_trans(Tween.TRANS_SINE)
	
	#if TransitionZoomTween:
		#TransitionZoomTween.kill()
	#TransitionZoomTween = create_tween()
	#var target_zoom = camara_objetivo.zoom
	#TransitionZoomTween.tween_property(camera_transicion,"zoom",target_zoom,0.5).set_trans(Tween.TRANS_SINE)
	#
	#if Transition0ffsetTween:
		#Transition0ffsetTween.kill()
	#Transition0ffsetTween = create_tween()
	#var target_offset = camara_objetivo.offset
	#Transition0ffsetTween.tween_property(camera_transicion,"offset",target_offset,0.5).set_trans(Tween.TRANS_SINE)
	#
	camara_actual = camara_objetivo
	
func regresar_camara():
	cambio_camara(camara_Player)
	await get_tree().create_timer(0.5).timeout
	#para que el jugador no se pueda mover en la transicion
	Global.interactuando = false
	camara_actual.current = true
	camera_transicion.current = false
