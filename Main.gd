extends Node

export (PackedScene) var Mob
var score


func _ready():
	randomize()
	
func new_game():
	score = 0
	$HUD.update_score(score)
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.show_message("Get Ready")
	$Music.play()
	
func game_over():
	$DeathSound.play()
	$Music.stop()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	

func _on_MobTimer_timeout():
	# choose a random location on the Path2D
	$MobPath/MobSpawnLocation.set_offset(randi())
	var mob = Mob.instance()
	add_child(mob)
	var direction = $MobPath/MobSpawnLocation.rotation + PI/2
	mob.position = $MobPath/MobSpawnLocation.position
	mob.rotation = direction
	mob.set_linear_velocity(Vector2(rand_range(mob.MIN_SPEED, mob.MAX_SPEED), 0).rotated(direction))
	
func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)
	
func _on_Pause_pressed():
	get_tree().paused = true
	$Popup_pause.show()
	$Popup_pause/ex_popup.show()
	$Music.stop()

func _on_New_game_pressed():
	get_tree().paused = false
	$Popup_pause.hide()
	$Popup_pause/ex_popup.hide()
	new_game()

func _on_Continue_pressed():
	get_tree().paused = false
	$Popup_pause.hide()
	$Popup_pause/ex_popup.hide()
	$Music.play()