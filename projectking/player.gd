class_name Player extends CharacterBody2D

var speed = 100

var input_velocity = Vector2.ZERO

var current_look_dir = "right"

# weapon variables 
var can_slash: bool = true
@export var slash_time: float = 0.2
@export var sword_return_time: float = 0.5
@export var weapon_damage: float = 1.0
 
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
	
	#look direction
	if current_look_dir == "right" and  get_global_mouse_position().x < global_position.x:
		$Sprite2D/flip_anim.play("look_left")
		current_look_dir = "left"
	elif current_look_dir == "left" and  get_global_mouse_position().x > global_position.x:
		$Sprite2D/flip_anim.play("look_right")
		current_look_dir = "right"
	
	if get_global_mouse_position().y > global_position.y:
		$Sprite2D/weapon.show_behind_parent = false
		$Sprite2D.frame = 0
	else:
		$Sprite2D/weapon.show_behind_parent = true
		# chang to fix a non game breaking error (investigate in future)
		#$Sprite2D.frame = 1
		$Sprite2D.frame = 0
		
	if Input.is_action_pressed("attack") and can_slash:
		$Sprite2D/weapon/AnimationPlayer.speed_scale = $Sprite2D/weapon/AnimationPlayer.get_animation("slash").length / slash_time
		$Sprite2D/weapon/AnimationPlayer.play("slash")
		can_slash = false

# Core melee attack code
const sword_slash_preload = preload("res://attack.tscn")
func spawn_attack():
	var sword_slash_var = sword_slash_preload.instantiate()
	sword_slash_var.global_position = global_position
	sword_slash_var.get_node("Sprite2D/AnimationPlayer").speed_scale = sword_slash_var.get_node("Sprite2D/AnimationPlayer").get_animation("slash").length / slash_time 
	sword_slash_var.get_node("Sprite2D").flip_v = false if get_global_mouse_position().x > global_position.x else true
	sword_slash_var.weapon_damage = weapon_damage
	get_parent().add_child(sword_slash_var)
	
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "slash":
		$Sprite2D/weapon/AnimationPlayer.speed_scale = $Sprite2D/weapon/AnimationPlayer.get_animation("sword_return").length / sword_return_time
		$Sprite2D/weapon/AnimationPlayer.play("sword_return")
	else:
		can_slash = true
