extends Node2D

#	1 : BLUE
#	2 : RED
#	3 : GREEN

signal floors_changed

func _change_floors():
	for s in get_children():
		for l in s.get_overlapping_bodies():
			if l is TileMap:
				var tile_pos = l.world_to_map(s.global_position)
				l.set_cellv(tile_pos, 2)
			else:
				return
	MainInstances.plant_seed = null
	emit_signal("floors_changed")

func _toggle_areas():
	for area in get_children():
		area.get_child(0).disabled = !area.get_child(0).disabled
