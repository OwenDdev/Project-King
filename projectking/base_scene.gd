class_name BaseScene extends Node

@onready var player: Player = $PlayerK
@onready var entrance_markers: Node2D = $EntranceMarkers

func _ready() -> void:
	if scene_manager.player:
		if player:
			scene_manager.player = player
		
		player = scene_manager.player
		add_child(player)
		position_player()

func position_player() -> void:
	for entrance in entrance_markers.get_children():
		if entrance is Marker2D and entrance.name == "any":
			player.global_position = entrance.global_position
