extends Node
signal got_to_next_level()
signal got_reseted()
const _N_ELEMENTS: int = 3 
const _MAX_COUNTER: int = 20
const _POINTS: String = "Points: "
var _elim_target: Sprite
var _curr_points: int
var _points_l: Label
var _car_spawn: Node
var _counter: int
var _n_elements_reseted: int

func _ready():
# warning-ignore:return_value_discarded
	self.connect("got_reseted", WorldClock, "reset")
# warning-ignore:return_value_discarded
	self.connect("got_reseted", SequenceGenerator, "reset")
# warning-ignore:return_value_discarded
	self.connect("got_to_next_level", WorldClock, "increment_frequency")
	CarGenerator.set_world(self)
# warning-ignore:return_value_discarded
	SequenceGenerator.connect("got_seq", CarGenerator, "create_car")
# warning-ignore:return_value_discarded
	SequenceGenerator.connect("reseted", self, "on_element_got_reseted")
# warning-ignore:return_value_discarded
	WorldClock.connect("timeout", SequenceGenerator, "_on_WorldClock_timeout")
# warning-ignore:return_value_discarded
	WorldClock.connect("timeout", self, "increment_points")
# warning-ignore:return_value_discarded
	WorldClock.connect("reseted", self, "on_element_got_reseted")
	WorldClock.start()
	self._elim_target = null
	self._curr_points = 0
	self._counter = 0
	self._points_l = $Points
	self._points_l.text = self._POINTS + str(self._curr_points)
	self._car_spawn = $CarSpawn

func on_Car_out_screen(car: Sprite) -> void:
	if self._elim_target:
		self._elim_target.free()
		self._elim_target = null
	self._car_spawn.remove_child(car)
	self._elim_target = car

func spawn_car(car: Sprite) -> void:
	self._car_spawn.add_child(car)

func increment_points() -> void:
	self._curr_points += 1
	self._points_l.text = self._POINTS + str(self._curr_points)
	self._counter += 1
	if self._counter == self._MAX_COUNTER:
		self._counter = 0
		self.emit_signal("got_to_next_level")

func reset() -> void:
	self._elim_target = null
	self._curr_points = 0
	self._points_l.text = self._POINTS + str(self._curr_points)
	for child in self._car_spawn.get_children():
		self._car_spawn.remove_child(child)
		child.free()
	self._n_elements_reseted = 0
	self.emit_signal("got_reseted")

func on_element_got_reseted() -> void:
	self._n_elements_reseted += 1
	if self._n_elements_reseted == self._N_ELEMENTS:
		$Reset.hide()
		$Player.show()
		WorldClock.start()

func _on_Player_collided():
	WorldClock.stop()
	$Reset.show()
