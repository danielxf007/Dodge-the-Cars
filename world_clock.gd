extends Timer

const _INITIAL_FREQUENCY: float = 4.0
var _frequency: float

func _ready():
	self.autostart = true
	self._frequency = self._INITIAL_FREQUENCY
	self.wait_time = 1.0/self._frequency
	

func increment_frequency() -> void:
	self._frequency += 1.0
	self.wait_time = 1.0/self._frequency

func reset() -> void:
	self._frequency = self._INITIAL_FREQUENCY

func stop_clock() -> void:
	self.paused = true

func resume_clock() -> void:
	self.paused = false
