class_name PlayerStateJump extends PlayerState

@export var jump_force : float = 450
func init() -> void:
	print("init!", name)

func enter():
	player.animation_player.play("jump")
	player.animation_player.pause()
	#player.add_debug_indicator(Color.LIME_GREEN)
	player.velocity.y = -jump_force
	
func exit():
	
	#player.add_debug_indicator(Color.YELLOW)
	pass
func handle_input(event:InputEvent) -> PlayerState:
	if event.is_action_released("ui_jump"):
		player.velocity.y *= 0.3
		return fall
	return next_state 

func process(_delta: float) -> PlayerState:
	set_jump_frame()
	return next_state
	
func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		return idle
	elif player.velocity.y >= 0:
		return fall
		
	player.velocity.x = player.direction.x * player.move_speed 
	return next_state
func set_jump_frame():
	var frame : float = remap(player.velocity.y, -jump_force, 0.0,0.0,0.5)
	player.animation_player.seek(frame,true)
