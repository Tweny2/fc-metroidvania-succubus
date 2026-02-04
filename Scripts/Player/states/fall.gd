class_name PlayerStateFall extends PlayerState

#region /// Export Variable
@export var coyote_time : float = 0.125
@export var jump_buffer_time : float = 0.2
@export var fall_mass : float = 1.165

var coyote_timer : float
var buffer_timer : float
#endregion

func init() -> void:
	print("init!", name)

func enter():
	player.animation_player.play("jump")
	player.animation_player.pause()
	player.mass = fall_mass
	if player.previous_state == jump:
		coyote_timer = 0
	else:
		coyote_timer = coyote_time
func exit():
	player.mass = 1 
	buffer_timer = 0
	pass 
	
func handle_input(event:InputEvent) -> PlayerState:
	if event.is_action_pressed("ui_accept"):
		if coyote_timer > 0:
			return jump
		else:
			buffer_timer = jump_buffer_time 
				
	return next_state 

func process(delta: float) -> PlayerState:
	coyote_timer -= delta
	buffer_timer -= delta
	set_jump_frame()
	return next_state
	
func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		player.add_debug_indicator()
		if buffer_timer > 0 and Input.is_action_pressed("ui_jump"):
			return jump    #大跳
		return idle
		
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
	
func set_jump_frame():
	var frame : float = remap(player.velocity.y, 0.0,player.max_fall_velocity,0.5,1.0)
	player.animation_player.seek(frame,true)
