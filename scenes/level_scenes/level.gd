extends Node3D

@export_file("*.dtl") var timeout_timeline : String

@onready var music_player : AudioStreamPlayer = $AudioStreamPlayer
@onready var moises_timer : Timer = $MoisesTimer
@onready var hud_timer : Label = $UserInterface/Label

func _ready() -> void:
	Dialogic.timeline_ended.connect(music_player.play, CONNECT_ONE_SHOT)
	Dialogic.timeline_started.connect(func() : moises_timer.paused = true)
	Dialogic.timeline_ended.connect(func() : moises_timer.paused = false)
	Dialogic.start_timeline("res://resources/timeline/intro.dtl")
	if timeout_timeline:
		moises_timer.timeout.connect(Dialogic.start_timeline.bind(timeout_timeline))

func _process(_delta):
	hud_timer.text = "0" + str(int(moises_timer.time_left/60)) + ":" + (("0" + str(int(moises_timer.time_left)%60)) if (int(moises_timer.time_left)%60<10) else str(int(moises_timer.time_left)%60))

func stop_music() -> void:
	music_player.stop()
