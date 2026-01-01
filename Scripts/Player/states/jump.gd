class_name PlayerStateJump extends PlayerState

@export var jump_force : float = 450
func init() -> void:
	print("init!", name)

func enter():
	player.add_debug_indicator(Color.LIME_GREEN)
	player.velocity.y = -jump_force
	
func exit():
	
	player.add_debug_indicator(Color.YELLOW)
	
func handle_input(event:InputEvent) -> PlayerState:
	if event.is_action_released("ui_accept"):
		player.velocity.y *= 0.5
		return fall
	return next_state 

func process(_delta: float) -> PlayerState:
	
	return next_state
	
func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		return idle
	elif player.velocity.y >= 0:
		return fall
		
	player.velocity.x = player.direction.x * player.move_speed 
	return next_state
