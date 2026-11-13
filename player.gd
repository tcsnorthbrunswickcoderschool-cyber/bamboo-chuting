extends CharacterBody2D

func _ready() -> void:
	pass

@export var speed: float = 300.0
@export var animation_player: AnimationPlayer
@export var sprite: Sprite2D 
var facing : String = "front"

var direction : Vector2 = Vector2(0, 1)

var bamboo_shoot = preload("uid://c1a8qijighi5r")

func _physics_process(_delta: float) -> void:
	# Get input vector using default UI actions (or map your own in Project Settings)
	var input_direction := Input.get_vector("left", "right", "up", "down")
	
	# Calculate velocity
	velocity = input_direction * speed
	
	set_facing(input_direction)
	pick_animation(input_direction)
	
	# Move the character and handle collisions
	move_and_slide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Shoot"):
		var new_bamboo : BambooShoot = bamboo_shoot.instantiate()
		new_bamboo.initialize(direction, position-Vector2(20,0))
		owner.add_child(new_bamboo)
		
func set_facing(dir: Vector2) -> void:
	if dir == Vector2(0, 0):
		return
	if abs(dir.x) > abs(dir.y):
		facing = "side"
		if dir.x < 0:
			sprite.scale.x = -1
			direction = Vector2(-1, 0)
		elif dir.x > 0:
			sprite.scale.x = 1
			direction = Vector2(1, 0)
	elif dir.y > 0:
		facing = "front"
		direction = Vector2(0, 1)
	elif dir.y < 0:
		facing = "back"
		direction = Vector2(0, -1)
	
func pick_animation(dir: Vector2) -> void:
	if dir == Vector2.ZERO:
		animation_player.play(facing+"_idle")
	else:
		animation_player.play(facing+"_walk")
