extends NPC
var ya_hablo := false
func necesaria():
	self.hide()
	
	Mensajero.connect("fin_dialogo",fin_dialogo)

func fin_dialogo():
	if ya_hablo:
		self.queue_free()


func _on_triger_body_entered(objeto):
	print(objeto)
	if objeto.is_in_group("Player") and !ya_hablo:
		ya_hablo = true
		
		self.show()
		var dialogo = Dialogo.instantiate()
		add_child(dialogo)
		dialogo.nombre = nombre
		print(dialogo.nombre)
		dialogo.textos = textos
		dialogo.iniciar_dialogo()
