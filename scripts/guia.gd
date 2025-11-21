extends NPC

func necesaria():
	self.hide()
	
	Mensajero.connect("fin_dialogo",fin_dialogo)


func _on_area_3d_body_entered(objeto):
	if objeto.is_in_group("Player"):
		self.show()
		var dialogo = Dialogo.instantiate()
		add_child(dialogo)
		dialogo.nombre = nombre
		print(dialogo.nombre)
		dialogo.textos = textos
		dialogo.iniciar_dialogo()

func fin_dialogo():
	self.queue_free()
