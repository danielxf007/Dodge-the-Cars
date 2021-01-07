extends Node

const _START_POS: Vector2 = Vector2(32, -32)
const _OFFSET: float = 64.0
const _CAR_TYPES: Array = ["0", "1", "2", "3", "4", "5"]
var _car_scene: PackedScene = preload("res://obstacle/Car.tscn")
var _r_gen: RandomNumberGenerator
var _world: Node

func _ready():
	self._r_gen = RandomNumberGenerator.new()
	self._r_gen.randomize()

func set_world(world: Node) -> void:
	self._world = world

func create_car(seq: Array) -> void:
	var curr_pos: Vector2 = self._START_POS
	var car: Sprite
	var car_type: String
	for element in seq:
		if element:
			car = self._car_scene.instance()
			self._world.add_child(car)
# warning-ignore:return_value_discarded
			car.connect("got_out_screen", self._world, "on_Car_out_screen")
			car.global_position = curr_pos
			car_type = str(self._r_gen.randi_range(0, self._CAR_TYPES.size()-1))
			car.change_texture(car_type)
# warning-ignore:return_value_discarded
			WorldClock.connect("timeout", car, "move")
			car.show()
		curr_pos.x += self._OFFSET
