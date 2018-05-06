extends Node2D

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_Continue_pressed():
	if $Continue.is_pressed():
		get_tree().change_scene("res://Main.tscn")