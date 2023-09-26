extends Area2D

export var effect_value : int

signal collected(progressed_value)

func _on_Collectable_area_entered(area): 

	emit_signal("collected",effect_value)	
	_destroy_itself()

func _destroy_itself():
	queue_free()
	

