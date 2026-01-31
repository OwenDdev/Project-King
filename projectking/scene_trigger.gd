class_name SceneTrigger extends Area2D

@export var connected_scene: String #Name of the Scene to change to 
var scene_folder = "res://" 

func _on_body_entered(body: Node2D) -> void:
	scene_manager.change_scene(get_owner(), connected_scene)
 
