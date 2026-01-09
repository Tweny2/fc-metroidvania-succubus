extends Node

var i : int
var a : Array = [1,2,3,4]

func _ready():
	for i in a:
		if i >=3:
			print("yes")
