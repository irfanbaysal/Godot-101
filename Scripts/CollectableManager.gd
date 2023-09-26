extends Node2D

export (PackedScene) var Collectable
var sound_system
var new_ball
var godot

func _ready():
	_set_godot()
	_set_sound_system()
	_create_collectable()

func _create_collectable():
	new_ball = Collectable.instance()
	var random_position = Vector2(rand_range(0, 1000), rand_range(0, 500))
	new_ball.position = random_position
	call_deferred("_add_new_ball", new_ball)
	_connect_signals()


func _add_new_ball(ball):
	add_child(ball)

func _on_Collectable_collected(progressed_value):
	print_debug("Collected")
	if new_ball:
		#sound_system._set_stream_and_play(0)
		sound_system._set_stream_and_play_random()
		new_ball.queue_free()
				
	_create_collectable()

func _set_godot():
	godot = get_node("Godot")
	
func _set_sound_system():
	sound_system = get_node("SoundSystem")

func _connect_signals():
	new_ball.connect("collected", self, "_on_Collectable_collected")
	new_ball.connect("collected",godot,"_on_Collectable_collected")




