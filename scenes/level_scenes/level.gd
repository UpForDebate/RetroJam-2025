extends Node3D

@export var timeout_timeline : DialogicTimeline

@onready var music_player : AudioStreamPlayer = $AudioStreamPlayer
@onready var moises_timer : Timer = $MoisesTimer
@onready var hud_timer : Label = $UserInterface/Label

func _ready() -> void:
	moises_timer.start(moises_timer.wait_time)
	Dialogic.timeline_ended.connect(music_player.play, CONNECT_ONE_SHOT)
	Dialogic.timeline_started.connect(func() : moises_timer.paused = true)
	Dialogic.timeline_ended.connect(func() : moises_timer.paused = false)
	Dialogic.start_timeline("res://resources/timeline/intro.dtl")
	if timeout_timeline:
		moises_timer.timeout.connect(Dialogic.start_timeline.bind(timeout_timeline))
	Dialogic.signal_event.connect(signal_handler)

func _process(_delta):
	hud_timer.text = "0" + str(int(moises_timer.time_left/60)) + ":" + (("0" + str(int(moises_timer.time_left)%60)) if (int(moises_timer.time_left)%60<10) else str(int(moises_timer.time_left)%60))

func stop_music() -> void:
	music_player.stop()

func signal_handler(_signal : String):
	get_tree().change_scene_to_packed(preload("res://scenes/credits-scene/credits.tscn"))
