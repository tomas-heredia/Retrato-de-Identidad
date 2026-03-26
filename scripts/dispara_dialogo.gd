extends Area3D

var Dialogo = load("res://Scenes/UI/dialogo.tscn")
@export var nombre:= "Narrador"
@export var textos: Array[Resource] = []
@export var One_shot: bool
var sin_uso:= true
@export var imagen : Texture2D
@export var rostro_img : Texture
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


func usado():
	self.hide()
	$CollisionShape3D.disabled = true


func _on_cuerpo_entered(objeto: Node3D) -> void:
	if !Global.interactuando and objeto.is_in_group("Player") and sin_uso:
		
		
		
		if One_shot:
			sin_uso = false
		var dialogo = Dialogo.instantiate()
		dialogo.imagen = imagen
		dialogo.nombre = nombre
		dialogo.textos = textos
		dialogo.rostro_img = rostro_img
	
		get_tree().root.add_child(dialogo)
		dialogo.iniciar_dialogo()
