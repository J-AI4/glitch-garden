extends Node2D

var plant_card_active = false

func get_nearest_tile():
	var tilemap = $TileMap
	var panda_pos = $Player.position
	var cell = tilemap.world_to_map(panda_pos)
	return cell


func _on_plant_pressed() -> void:
	plant_card_active = true

func _process(delta):
	if plant_card_active and Input.is_action_just_pressed("ui_select")
