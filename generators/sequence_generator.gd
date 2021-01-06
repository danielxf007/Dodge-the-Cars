extends Node
signal got_seq(seq)
const _ELEMENTS: Array = [0, 1]
const _ZERO: int = 0
const _ONE: int = 1
const _SEQ_LEN: int = 8
var _seqs: Array
var _r_gen: RandomNumberGenerator
var _curr_seq: Array
var _cycle_delay: int
var _n_curr_cycles: int

func _ready():
	self._r_gen = RandomNumberGenerator.new()
	self._r_gen.randomize()
	self._seqs = []
	self.create_sequences([])
	var index: int = self._r_gen.randi_range(self._ZERO, self._seqs.size()-1)
	self._curr_seq = self._seqs[index]
	self._cycle_delay = 10
	self._n_curr_cycles = 10

func valid_sequence(curr_seq: Array) -> bool:
	return curr_seq.has(self._ZERO) and curr_seq.has(self._ONE)

func create_sequences(curr_seq: Array) -> void:
	if curr_seq.size() == self._SEQ_LEN:
		if self.valid_sequence(curr_seq):
			self._seqs.append(curr_seq.duplicate())
	else:
		for element in self._ELEMENTS:
			curr_seq.append(element)
			self.create_sequences(curr_seq)
			curr_seq.pop_back()

func get_zeros_index() -> Array:
	var zeros_index: Array = []
	for index in range(self._curr_seq.size()):
		if self._curr_seq[index] == self._ZERO:
			zeros_index.append(index)
	return zeros_index

func choose_indexes(quantity: int, indexes: Array) -> Array:
	var _indexes: Array = []
	var index: int
	while quantity:
		index = self._r_gen.randi_range(self._ZERO, indexes.size()-1)
		_indexes.append(indexes[index])
		indexes.remove(index)
		quantity -= self._ONE
	return _indexes

func filter_sequences(indexes: Array) -> Array:
	var sequences: Array = []
	for seq in self._seqs:
		for index in indexes:
			if seq[index] == self._ZERO:
				sequences.append(seq)
				break
	return sequences

func choose_sequence(sequences: Array) -> Array:
	var index = self._r_gen.randi_range(self._ZERO, sequences.size()-1)
	return sequences[index]

func _on_WorldClock_timeout() -> void:
	if self._n_curr_cycles == self._cycle_delay:
		var zeros_ind: Array = self.get_zeros_index()
		var quantity: int = self._r_gen.randi_range(self._ZERO, zeros_ind.size()-1)
		if quantity:
			var indexes: Array = self.choose_indexes(quantity, zeros_ind)
			var sequences: Array = self.filter_sequences(indexes)
			self._curr_seq = self.choose_sequence(sequences)
		else:
			self._curr_seq = self.choose_sequence(self._seqs)
		self.emit_signal("got_seq", self._curr_seq)
		self._n_curr_cycles = self._ZERO
	else:
		self._n_curr_cycles += self._ONE
