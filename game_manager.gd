extends Node2D

var plant_card_active = false
var bamboo_stack = {}

func get_nearest_tile():
	var tilemap = $TileMap
	var panda_pos = $Player.position
	var cell = tilemap.world_to_map(panda_pos)
	return cell


func _on_plant_pressed() -> void:
	plant_card_active = true

func _process(delta):
	if plant_card_active and Input.is_action_just_pressed("ui_select"):
		var cell = get_nearest_tile()
		var pos_key = Vector2(cell.x, cell.y)
		
		var height = 0
		if bamboo_stack.has(pos_key):
			height = bamboo_stack[pos_key]
			bamboo_stack[pos_key] += 1
		else:
			bamboo_stack[pos_key] = 1

		var tile_size = Vector2(31, 32)
		var world_pos = $TileMap.map_to_world(cell)
		world_pos.y -= height * tile_size.y
		
		var bamboo = Sprite2D.new()
		bamboo.texture = preload("res://bamboo (2).png")
		bamboo.position = world_pos
		$PlantsTileMap.add_child(bamboo)
