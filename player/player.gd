extends Sprite
signal collided()
signal reseted()
const _START_POS: Vector2 = Vector2(224, 608)
const _DIMENSIONS: Vector2 = Vector2(56, 56)
const _MOVEMENT_STEP: int = 64
const _MIN_ROW: int = 0
const _MAX_ROW: int = 9
const _MIN_COLUMN: int = 0
const _MAX_COLUMN: int = 6
var _curr_row: int
var _curr_col: int

func _ready():
	var dimensions: Vector2 = self.region_rect.size
	self.scale.x = self._DIMENSIONS.x/dimensions.x
	self.scale.y = self._DIMENSIONS.y/dimensions.y
	self.global_position = self._START_POS
	self._curr_col = 3
	self._curr_row = 9

func _input(event):
	if event.is_action_pressed("ui_right"):
		if self._curr_col < self._MAX_COLUMN:
			self.global_position.x += self._MOVEMENT_STEP
			self._curr_col += 1
	elif event.is_action_pressed("ui_left"):
		if self._curr_col > self._MIN_COLUMN:
			self.global_position.x -= self._MOVEMENT_STEP
			self._curr_col -= 1
	elif event.is_action_pressed("ui_down"):
		if self._curr_row < self._MAX_ROW:
			self.global_position.y += self._MOVEMENT_STEP
			self._curr_row += 1
	elif event.is_action_pressed("ui_up"):
		if self._curr_row > self._MIN_COLUMN:
			self.global_position.y -= self._MOVEMENT_STEP
			self._curr_row -= 1

func _on_Area2D_area_entered(_area) -> void:
	self.set_process_input(false)
	self.hide()
	self.emit_signal("collided")


func _on_Main_got_reseted():
	self.set_process_input(true)
	self.global_position = self._START_POS
	self._curr_col = 3
	self._curr_row = 9
	self.emit_signal("reseted")
