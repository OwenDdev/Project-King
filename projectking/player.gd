extends CharacterBody2D

var speed = 100

var input_velocity = Vector2.ZERO

var Inventory = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("Interact") :
		print(Inventory)

func _physics_process(delta: float) -> void:
	
	#Player Movement 
	if Input.is_action_pressed("Up"):
		input_velocity = Vector2(0, -1).normalized()
		velocity.y =  input_velocity.y * speed
		velocity.x = 0
	elif Input.is_action_pressed("Down"):
		input_velocity = Vector2(0, 1).normalized()
		velocity.y =  input_velocity.y * speed
		velocity.x = 0
	elif Input.is_action_pressed("Left"):
		input_velocity = Vector2(-1, 0).normalized()
		velocity.x =  input_velocity.x * speed
		velocity.y = 0
	elif Input.is_action_pressed("Right"):
		input_velocity = Vector2(1, 0).normalized()
		velocity.x =  input_velocity.x * speed
		velocity.y = 0
	else:
		velocity = Vector2.ZERO
		
	move_and_slide()
