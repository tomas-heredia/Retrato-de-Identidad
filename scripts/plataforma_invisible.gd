extends RigidBody3D

@onready var mesh: MeshInstance3D = $MeshInstance3D

@onready var collision: CollisionShape3D = $CollisionShape3D


var activado := false
func _ready() -> void:
	self.hide()
	collision.disabled = true


func activar():
	collision.set_deferred("disabled", false)
	self.show()
	
