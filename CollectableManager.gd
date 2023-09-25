extends Node2D

export (PackedScene) var Collectable

var new_ball
var godot

func _ready():
	_set_godot()
	_create_collectable()

func _create_collectable():
	new_ball = Collectable.instance()
	var random_position = Vector2(rand_range(0, 500), rand_range(0, 500))
	new_ball.position = random_position
	call_deferred("_add_new_ball", new_ball)
	_connect_signals()

	print_debug(new_ball)

func _add_new_ball(ball):
	add_child(ball)

func _on_Collectable_collected(progressed_value):
	print_debug("Collected")
	if new_ball:
		new_ball.queue_free()
	
	_create_collectable()

func _set_godot():
	godot = get_node("Godot")

func _connect_signals():
	new_ball.connect("collected", self, "_on_Collectable_collected")
	new_ball.connect("collected",godot,"_on_Collectable_collected")




