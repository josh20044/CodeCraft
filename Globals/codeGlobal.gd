extends Node

var current_space_index = -1
var code_coliding = false

signal grabcode
signal codeColided(index : int)
signal codeUnColided
signal coderemove(index : int)
