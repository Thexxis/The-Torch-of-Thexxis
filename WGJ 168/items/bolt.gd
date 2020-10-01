extends KinematicBody2D

var TYPE = null
const DAMAGE = 1
const SPEED = 2.5
var direction
onready var parent = get_parent()

func _ready():
	if parent.spritedir == "up":
		direction = dir.up * SPEED
	if parent.spritedir == "left":
		direction = dir.left * SPEED
	if parent.spritedir == "down":
		direction = dir.down * SPEED
	if parent.spritedir == "right":
		direction = dir.right * SPEED
	$anim.play(str("fire", parent.spritedir))

func _physics_process(delta):
	move_and_collide(direction)
	var collision = move_and_collide(direction * delta)
	if collision:
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
