class_name PlayerStateCrouch extends PlayerState

@export var deceleration_rate : float = 10 


func init() -> void:
	print("init!", name)

func enter():
	player.collision_stand.disabled = true
	player.collision_crouch.disabled = false
	player.sprite.scale.y = 0.5
	player.sprite.position.y = -8
	
func exit():
	player.collision_stand.disabled = false
	player.collision_crouch.disabled = true
	player.sprite.scale.y = 0.938
	player.sprite.position.y = -15
	
func handle_input(event:InputEvent) -> PlayerState:
	if event.is_action_pressed("ui_accept"):
		if player.one_way_platform_ray_cast.is_colliding() == true:
			player.position.y += 4
			return fall
		return jump
	return next_state 

func process(_delta: float) -> PlayerState:
	if player.direction.y < 0.5 :
		return idle
	return next_state
	
func physics_process(delta: float) -> PlayerState:
	player.velocity.x -= player.velocity.x * deceleration_rate * delta
	if player.is_on_floor() == false: 
		return fall
	return next_state
 
