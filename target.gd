extends CharacterBody2D

@export var area : Area2D

func _ready() -> void:
	area.area_entered.connect(got_hit)

func got_hit(area: Area2D) -> void:
	if area.owner and area.owner is BambooShoot:
		area.owner.queue_free() 
		hide()
		start_respawn_timer()
		
func start_respawn_timer() -> void:
	var timer : Timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.wait_time = 5.0
	timer.timeout.connect(show)
	timer.start()
