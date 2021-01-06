extends Node

func _ready():
# warning-ignore:return_value_discarded
	SequenceGenerator.connect("got_seq", CarGenerator, "create_car")
# warning-ignore:return_value_discarded
	WorldClock.connect("timeout", SequenceGenerator, "_on_WorldClock_timeout")
	WorldClock.start()
