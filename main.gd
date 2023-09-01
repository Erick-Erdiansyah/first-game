extends Node

@export var mob_scene : PackedScene
var score

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("get ready!!!")
	
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_mob_timer_timeout():
	#instansiasi mob baru/ spawn baru
	var mob = mob_scene.instantiate()
	#milih lokasi mob di path2d
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	# set lokasi mob searah sama jalur dia jalan
	var direction = mob_spawn_location.rotation + PI / 2
	#set lokasi mob di lokasi acak
	mob.position = mob_spawn_location.position
	#supaya arah mobnya acak
	direction += randf_range(-PI /4, PI / 4)
	mob.rotation = direction
	#mob velocity
	var velocity = Vector2(randf_range(150.0,250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	#spawn the mob in main scene
	add_child(mob)
	
