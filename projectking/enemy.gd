extends CharacterBody2D

var health: float = 3.0

func take_damage(weapon_damge: float):
	self.modulate = Color.WHITE
	health -= weapon_damge
	
	if health <= 0.0:
		queue_free()
	
 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
