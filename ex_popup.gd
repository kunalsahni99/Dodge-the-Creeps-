extends Popup

func _on_exit_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Main.tscn")