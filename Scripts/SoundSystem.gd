extends AudioStreamPlayer2D

export var soundArray : Array

func _set_stream_sound(sound_index):
	stream = soundArray[sound_index]

func _play_sound():
	play()

func _set_stream_and_play(sound_index):
	_set_stream_sound(sound_index)
	play()
	
func _set_stream_and_play_random():
	_set_stream_sound(_select_random_sound())
	play()

func _stop_sound():
	stop()	
	
func _select_random_sound():
	var selected_random = randi() % (soundArray.size())
	#print_debug(selected_random)
	return selected_random     



