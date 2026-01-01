@icon("res://Assets/Icon/state.svg")
class_name PlayerState extends Node

var player : Player
var next_state : PlayerState


#region /// state references
@onready var idle: PlayerStateIdle = %Idle
@onready var run: PlayerStateRun = %Run
@onready var jump: PlayerStateJump = %Jump
@onready var fall: PlayerStateFall = %Fall




#endregion

func init() -> void:
	print("init!", name)

func enter():
	pass
func exit():
	pass 
	
func handle_input(event:InputEvent) -> PlayerState:
	
	return next_state 

func process(_delta: float) -> PlayerState:
	
	return next_state
	
func physics_process(_delta: float) -> PlayerState:
	#print("1")
	return next_state
