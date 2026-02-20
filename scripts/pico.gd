extends RigidBody3D

@export var daño := 25
@export var empuje := 12
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(objeto: Node3D) -> void:
	if objeto.is_in_group("Player"):
		objeto.recibir_daño(daño)
		var dir := objeto.global_position - global_position
		dir.y = 0   # eliminamos empuje vertical
		dir = dir.normalized()
		objeto.velocity += dir * empuje
