extends Timer
signal reseted()
const _FREQUENCY_INCREMENT: float = 0.5
const _INITIAL_FREQUENCY: float = 1.0
var _frequency: float

func _ready():
	self.autostart = true
	self._frequency = self._INITIAL_FREQUENCY
	self.wait_time = 1.0/self._frequency
	

func increment_frequency() -> void:
	self._frequency += self._FREQUENCY_INCREMENT
	self.wait_time = 1.0/self._frequency

func reset() -> void:
	self._frequency = self._INITIAL_FREQUENCY
	self.wait_time = 1.0/self._frequency
	self.emit_signal("reseted")
