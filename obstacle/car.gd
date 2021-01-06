extends Sprite
signal got_to_last_row(car)
const _DIMENSIONS: Vector2 = Vector2(62, 62)
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
	if self._n_movements == self._MAX_MOVEMENTS-1:
		self.emit_signal("got_to_last_row", self)
	elif self._n_movements == self._MAX_MOVEMENTS:
		self.queue_free()
