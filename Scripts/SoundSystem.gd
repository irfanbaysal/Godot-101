extends AudioStreamPlayer2D

export var sound_resource : Resource

func _set_stream_sound(sound_index):
	stream = sound_resource.soundArray[sound_index]

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
	var selected_random = randi() % (sound_resource.soundArray.size())
	return selected_random     



