extends RigidBody3D

@export var ruptura_timer :int = 1
@export var reconstruccion_timer : int = 3

@onready var collision_trigger: CollisionShape3D = $Area3D/CollisionShape3D
@onready var collision: CollisionShape3D = $CollisionShape3D
@onready var mesh: MeshInstance3D = $MeshInstance3D
@onready var timer_des: Timer = $ruptura_timer
@onready var timer_rec: Timer = $reconstruccion_timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer_des.wait_time = ruptura_timer
	timer_rec.wait_time = reconstruccion_timer
	# Duplicar el material para que sea único por instancia
	var mat = mesh.get_active_material(0)
	if mat:
		mesh.set_surface_override_material(0, mat.duplicate())

func _on_area_3d_body_entered(objeto: Node3D) -> void:
	if objeto.is_in_group("Player"):
		collision_trigger.set_deferred("disabled", true)
		mesh.get_active_material(0).albedo_color = Color(1, 0, 0)
		timer_des.start()
		


func _on_ruptura_timer_timeout() -> void:
	self.hide()
	collision.set_deferred("disabled", true)
	timer_rec.start()
	


func _on_reconstruccion_timer_timeout() -> void:
	mesh.get_active_material(0).albedo_color = Color(1, 1, 1)
	collision.set_deferred("disabled", false)
	collision_trigger.set_deferred("disabled", false)
	self.show()
