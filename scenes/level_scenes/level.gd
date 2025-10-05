extends Node3D

@onready var musicplayer : AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	Dialogic.start_timeline("res://resources/timeline/intro.dtl")
	Dialogic.timeline_ended.connect(musicplayer.play)
	
func stop_music() -> void:
	musicplayer.stop()
