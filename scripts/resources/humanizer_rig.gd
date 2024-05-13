extends Resource
class_name HumanizerRig

@export var mh_json_path: String
@export var mh_weights_path: String
@export var bone_weights_json_path: String
@export var config_json_path: String
@export var skeleton_path: String
@export var skeleton_retargeted_path: String
@export var rigged_mesh_path: String

func load_skeleton() -> Skeleton3D:
	return load(skeleton_path).instantiate()

func load_retargeted_skeleton() -> Skeleton3D:
	return load(skeleton_retargeted_path).instantiate()

func load_bone_weights() -> Dictionary:
	var json := FileAccess.get_file_as_string(mh_weights_path)
	var weights: Dictionary = JSON.parse_string(json).weights
	for in_name: String in weights.keys():
		if ":" not in in_name:
			continue
		var out_name = in_name.replace(":", "_")
		weights[out_name] = weights[in_name]
		weights.erase(in_name)
	return weights
