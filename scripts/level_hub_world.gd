extends Node3D
var imagen = preload("res://Assets/UI/Barra_vida/avatar.png")

var Dialogo = load("res://Scenes/UI/dialogo.tscn")
@export var nombre:= "Narrador"
@export var textos: Array[Resource] = []
@onready var guia_dialogo: CollisionShape3D = $Guia/triger/CollisionShape3D
@onready var dispara_dialogo: Area3D = $Dispara_Dialogo
@onready var dialogo_huellas: Area3D = $Dialogo_huellas
@onready var dispara_dialogo_2: Area3D = $Dispara_Dialogo2

@onready var recolectable: Area3D = $Dialogo_huellas/Recolectable
@onready var recolectable_1: Area3D = $Recolectable
@onready var recolectable_2: Area3D = $Recolectable2
@onready var recolectable_3: Area3D = $Recolectable3
@onready var recolectable_4: Area3D = $Recolectable4
@onready var level_1_marker: Marker3D = $Level1_marker
@onready var player: CharacterBody3D = $Player
@onready var portal_lv_1: MeshInstance3D = $Portal_LV1
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	print(Guardado.game_data.hub_visitado) 
	if !Guardado.game_data.hub_visitado:
		Global.interactuando = true
		Mensajero.Crear_pensamiento.emit("¿Qué pasó?\n¿Dónde estoy?\nNo recuerdo nada…")
		await get_tree().create_timer(5).timeout
		
		var dialogo = Dialogo.instantiate()
		dialogo.nombre = nombre
		dialogo.textos = textos
		dialogo.rostro_img = imagen
		add_child(dialogo)
		dialogo.iniciar_dialogo()

	else:
		player.position = level_1_marker.position
		#guia_dialogo.disabled = true
		dispara_dialogo.usado()
		dispara_dialogo_2.usado()
		
		dialogo_huellas.usado()
		recolectable.recolectado()
		recolectable_1.recolectado()
		recolectable_2.recolectado()
		recolectable_3.recolectado()
		recolectable_4.recolectado()
		
	if(Guardado.game_data.level_1_visitado):
		portal_lv_1.desactivar()
