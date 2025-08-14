extends Node2D

func get_nearest_tile():
	var tilemap = $TileMap
	var panda_pos = $Player.position
	var cell = tilemap.world_to_map(panda_pos)
	return cell
