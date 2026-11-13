class_name BambooShoot extends Node2D

var direction : Vector2
var speed: float = 8.0
@export var sprite : Sprite2D


func initialize(_direction: Vector2, _pos: Vector2) -> void:
	position = _pos
	direction = _direction
	sprite.rotation = atan2(direction.y, direction.x)
	sprite.rotation_degrees += 90
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed
