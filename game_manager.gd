extends Node2D

var plant_card_active = false
var super_grow_card_active = false
var bamboo_stack = {}
var plant_uses = 0

func get_nearest_tile():
	var tilemap = $TileMap
	var panda_pos = $Player.global_position
	var local_pos = tilemap.to_local(panda_pos)
	var cell = tilemap.local_to_map(local_pos)
	return cell


func _on_plant_pressed() -> void:
	plant_card_active = true
	super_grow_card_active = false
	print("hello")
	
func _on_super_grow_pressed() -> void:
	super_grow_card_active = true
	plant_card_active = false
			
func _process(delta):
	if plant_card_active and Input.is_action_just_pressed("ui_select"):
		place_bamboo(1)
	
	if super_grow_card_active and Input.is_action_just_pressed("ui_select"):
		place_bamboo(3)

func place_bamboo(amount):
		var cell = get_nearest_tile()
		var pos_key = Vector2(cell.x, cell.y)
		
		var height = 0
		if bamboo_stack.has(pos_key):
			height = bamboo_stack[pos_key]
			bamboo_stack[pos_key] += 1
		else:
			bamboo_stack[pos_key] = 1

		var tile_size = Vector2(310, 320)
		
		var world_pos = $TileMap.map_to_local(cell)
		world_pos.y -= tile_size.y + 320
		
		world_pos.y -= height * tile_size.y
		
		for i in range(amount):
			var bamboo = Sprite2D.new()
			bamboo.texture = preload("res://bamboo (2).png")
			bamboo.position = world_pos
			$PlantsTileMap.add_child(bamboo)
			world_pos.y -= tile_size.y
			
		if plant_card_active:
			plant_uses += 1
			if plant_uses >= 6:
				$SuperGrow.visible = true
