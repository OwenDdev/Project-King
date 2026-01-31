class_name SceneManger extends Node

var player: Player

var scene_dir_path = "res://"

func _ready() -> void:
	pass
		
func change_scene(from, to_scene_name : String) -> void:
	player = from.player
	if player and player.get_parent():
		player.get_parent().remove_child(player) 
	
	var full_path =  scene_dir_path + to_scene_name + ".tscn"
	from.get_tree().call_deferred("change_scene_to_file", full_path)
