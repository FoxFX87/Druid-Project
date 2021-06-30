extends Node2D

func _on_EnemyTracker__all_enemies_defeated():
	var _reset_scene = get_tree().reload_current_scene()
