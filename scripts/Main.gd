extends Node


var Niveau = preload("res://scenes/Level.tscn")
var niveau


# Called when the node enters the scene tree for the first time.
func _ready():
	niveau = Niveau.instance()
	add_child(niveau)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
