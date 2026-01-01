class_name PlayerStateIdle extends PlayerState


func init() -> void:
	print("init!", name)

func enter():
	pass
func exit():
	pass 
	
func handle_input(event:InputEvent) -> PlayerState:
	if event.is_action_pressed("ui_accept"):
		return jump
	return next_state 

func process(_delta: float) -> PlayerState:
	if player.direction.x != 0:
		return run
	return next_state
	
func physics_process(_delta: float) -> PlayerState:
	player.velocity.x = 0
	if player.is_on_floor() == false:
		return fall
	return next_state
