extends Node

var _elim_target: Sprite

func _ready():
	CarGenerator.set_world(self)
# warning-ignore:return_value_discarded
	SequenceGenerator.connect("got_seq", CarGenerator, "create_car")
# warning-ignore:return_value_discarded
	WorldClock.connect("timeout", SequenceGenerator, "_on_WorldClock_timeout")
	WorldClock.start()
	self._elim_target = null

func on_Car_out_screen(car: Sprite) -> void:
	if self._elim_target:
		self._elim_target.free()
		self._elim_target = null
	self.remove_child(car)
	self._elim_target = car
