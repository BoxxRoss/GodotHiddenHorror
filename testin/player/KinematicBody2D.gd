extends KinematicBody2D


var movespeed = 200
var bullet_speed = 750
var bullet = preload("res://player/bulletscene.tscn")


func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("Up"):
		motion.y -= 1
	if Input.is_action_pressed("Down"):
		motion.y += 1
	if Input.is_action_pressed("Left"):
		motion.x -= 1
	if Input.is_action_pressed("Right"):
		motion.x += 1
		
	motion = motion.normalized()
	motion = move_and_slide(motion * movespeed)
	look_at(get_global_mouse_position())

	if Input.is_action_just_pressed("Shoot"):
		fire()

func fire ():
	var bullet_instance = bullet.instance()
	bullet_instance.position = $bulletpoint.get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(),Vector2(bullet_speed,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child", bullet_instance)
	
func kill():
	get_tree().reload_current_scene()
	
	



func _on_Area2D_body_entered(body):
	if "enemy" in body.name:
		kill()
