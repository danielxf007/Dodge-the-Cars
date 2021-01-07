extends Sprite
signal got_out_screen(car)
const _DIMENSIONS: Vector2 = Vector2(56, 56)
const _MAX_MOVEMENTS: int = 12
const _MOVEMENT_STEP: int = 64
var _n_movements: int

func _ready():
	self.rescale()
	self._n_movements = 0

func rescale() -> void:
	var dimensions: Vector2 = self.region_rect.size
	self.scale.x = self._DIMENSIONS.x/dimensions.x
	self.scale.y = self._DIMENSIONS.y/dimensions.y

func change_texture(texture_name: String) -> void:
	$AnimationPlayer.play(texture_name)
	self.rescale()

func move() -> void:
	self.global_position.y += self._MOVEMENT_STEP
	self._n_movements += 1
	if self._n_movements == self._MAX_MOVEMENTS:
		WorldClock.disconnect("timeout", self, "move")
		self.emit_signal("got_out_screen", self)
