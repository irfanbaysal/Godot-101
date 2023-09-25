extends Sprite

var angular_speed = PI;
var speed = 400.0

export var progressValueIncrementer : int
export var followSpeed : int
var progressedValue = 0	
signal timer_applied(progressed_value)
# Awake
func _init():
	print_debug("Init")
# Ready	
func _ready():
	_useTimer()
	print_debug("Ready")
func _enter_tree():
	print_debug("Enter tree")
func _exit_tree():
	print_debug("Exit tree")

func _process(delta):
	_applyInput(delta)
	
func _applyInput(delta):
	var direction = 0;
	if(Input.is_action_pressed("ui_left")):
		direction = -1
	if(Input.is_action_pressed("ui_right")):
		direction = 1
	if(Input.is_action_just_pressed("ui_down")):
		print_debug("Pressed down")
	if(Input.is_key_pressed(KEY_A)):
		print_debug("Pressed A")
		
	rotation += angular_speed * delta * direction
	
	var velocity = Vector2.ZERO;
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2.UP.rotated(rotation) * speed
		
	position += velocity*delta 
	
#func _input(event):
#	if event is InputEventMouseMotion:
#		position = get_viewport().get_mouse_position()
		

func _physics_process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	position = position.linear_interpolate(mouse_pos, delta * followSpeed)
	
func _on_Button_pressed():
	_refresh_progress_bar()
	
func _refresh_progress_bar():
	progressedValue=0
	
func _useTimer():
	var timer = get_node("Timer")
	timer.connect("timeout",self,"_on_apply_timeout")
		
func _on_apply_timeout():
	progressedValue+=progressValueIncrementer
	emit_signal("timer_applied",progressedValue)
	_set_alpha()

func _on_Collectable_collected(progressed_value):
	progressedValue += progressed_value
	_set_alpha()
	_scale_up_down()
	
func _set_alpha():
	var alpha = 1.0 - (progressedValue/100.0)
	alpha = clamp(alpha,0.0,1.0)
	modulate.a = alpha
	print_debug(modulate.a)
	
func _scale_up_down():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1.5,1.5), .25)
	tween.tween_interval(.15)
	tween.tween_property(self,"scale",Vector2(1,1),.25)
	tween.set_ease(Tween.EASE_IN_OUT)

	
