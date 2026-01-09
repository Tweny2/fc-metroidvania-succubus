class_name Player extends CharacterBody2D

const DEBUG_JUMP_INDICATOR = preload("uid://c2iigg6p4pfxu")

#region /// Onready Variables
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_stand: CollisionShape2D = $CollisionStand
@onready var collision_crouch: CollisionShape2D = $CollisionCrouch
@onready var one_way_platform_ray_cast: RayCast2D = $OneWayPlatformRayCast

#endregion

#region /// Export Variables
@export var move_speed :float = 150

#endregion


#region /// State Machine Variables
var states : Array[PlayerState]
var current_state : PlayerState:
	get : return states.front()
var previous_state : PlayerState:
	get : return states[1]

#endregion

#region /// Standard Variables
var direction : Vector2 = Vector2.ZERO
var gravity : float = 980 # 重力加速度
var mass : float = 1  # 质量
#endregion


func _ready() -> void:
	initialize_states()
	
func _process(delta: float) -> void:
	
	update_direction()
	change_state(current_state.process(delta))
	
func _physics_process(delta: float) -> void:
	#velocity.
	velocity.y += gravity * mass * delta 
	
	move_and_slide()
	
	change_state(current_state.physics_process(delta))
func _unhandled_input(event: InputEvent) -> void:
	
	change_state(current_state.handle_input(event))

func initialize_states() -> void:
	
	states = []
	
	for c in $States.get_children():
		if c is PlayerState:
			states.append(c)
			c.player = self
	if states.size() == 0:
		return
	for state in states:
		state.init()
	
	change_state(current_state)
	current_state.enter()
	$Label.text = current_state.name
	
func change_state(new_state : PlayerState) -> void :
	if new_state == null:
		return
	elif new_state == current_state:
		return
	if current_state:
		current_state.exit()
		
	states.push_front(new_state)
	current_state.enter()
	states.resize(3)
	$Label.text = current_state.name

func update_direction():
	var _pre_direction : Vector2 = direction
	
	var x_axis = Input.get_axis("ui_left","ui_right")
	var y_axis = Input.get_axis("ui_up","ui_down")
	
	direction = Vector2(x_axis, y_axis)
	
	pass

func add_debug_indicator(color : Color = Color.RED):
	var d : Node2D = DEBUG_JUMP_INDICATOR.instantiate()
	get_tree().root.add_child(d)
	d.global_position = global_position
	d.modulate = color
	await get_tree().create_timer(3).timeout
	d.queue_free()
