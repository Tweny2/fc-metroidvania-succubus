class_name PlayerStateFall extends PlayerState

@export var coyote_time : float = 0.4
var coyote_timer : float


func init() -> void:
	print("init!", name)

func enter():
	if player.previous_state == jump:
		coyote_timer = 0
	else:
		coyote_timer = coyote_time
func exit():
	pass 
	
func handle_input(event:InputEvent) -> PlayerState:
	if event.is_action_pressed("ui_accept"):
		if coyote_timer > 0:
			return jump
	return next_state 

func process(delta: float) -> PlayerState:
	coyote_timer -= delta
	return next_state
	
func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		player.add_debug_indicator()
		return idle
		
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
