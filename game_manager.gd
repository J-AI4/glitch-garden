extends Node2D

var plant_card_active = false
var remove_card_active = false
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
	remove_card_active = false
	
func _on_super_grow_pressed() -> void:
	super_grow_card_active = true
	plant_card_active = false
	remove_card_active = false
	
func _on_remove_pressed() -> void:
	remove_card_active = true
	plant_card_active = false
	super_grow_card_active = false
			
func _process(delta):
	if plant_card_active and Input.is_action_just_pressed("ui_select"):
		place_bamboo(1)
	
	if super_grow_card_active and Input.is_action_just_pressed("ui_select"):
		place_bamboo(3)
	
	if remove_card_active and Input.is_action_just_pressed("ui_select"):
		remove_bamboo()
		
	if $Player.global_position.y > 320:
		$Background.visible = true
	else:
		$Background.visible = false
		
func place_bamboo(amount):
		var cell = get_nearest_tile()
		var pos_key = Vector2(cell.x, cell.y)
		
		var height = 0
		if bamboo_stack.has(pos_key):
			height = bamboo_stack[pos_key]
			bamboo_stack[pos_key] += amount
		else:
			bamboo_stack[pos_key] = amount

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
	
func remove_bamboo():
	var cell = get_nearest_tile()
	var pos_key = Vector2(cell.x, cell.y)
	
	if bamboo_stack.has(pos_key) and bamboo_stack[pos_key] > 0:
		bamboo_stack[pos_key] -= 1
		var children = $PlantsTileMap.get_children()
		for i in range(children.size() - 1, -1, -1):
			if children[i].position.x == $TileMap.map_to_local(cell).x:
				children[i].queue_free()
				break
