extends entity

var movetimer_length = 15
var movetimer = 0

func _init():
	TYPE = "ENEMY"
	MAXHEALTH = 1.5
	health = 1.5
	SPEED = 30
	DAMAGE = 0.25

func _ready():
	$anim.play("default")
	movedir = dir.rand()
	movedir = dir.rand()

func _physics_process(delta):
	movement_loop()
	damage_loop()
	if movetimer > 0:
		movetimer -= 1
	if movetimer == 0 || is_on_wall():
		movedir = dir.rand()
		movetimer = movetimer_length
