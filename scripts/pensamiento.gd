extends Control

@onready var label = $Label
@onready var animation_player = $AnimationPlayer
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func Crear_pensamieto(texto: String):
	print(texto)
	label.text = texto
	self.size = label.size
	animation_player.play("In")
	timer.start()


func _on_timer_timeout():
	Mensajero.pensamiento_fin.emit()
	animation_player.play("Out")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Out":
		self.queue_free()
