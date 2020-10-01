extends entity

var state = "default"
var keys = 0
var role

func _init():
	MAXHEALTH = 16
	health = 3
	TYPE = "PLAYER"
	SPEED = 60
	DAMAGE = null

func _ready():
	randomize()
	var role = randi() % 3
	if role == 0:
		print("Knight!")
	elif role == 1:
		print("Ranger!")
	elif role == 2:
		print("Grenadier!")
	else:
		print("SUPER")


func _physics_process(delta):
	match state:
		"default":
			state_default()
		"swing":
			state_swing()
		"fire":
			state_fire()
		"throw":
			state_throw()
	
	keys = min(keys, 9)

func state_default():
	controls_loop()
	movement_loop()
	spritedir_loop()
	damage_loop()
	
	if is_on_wall() and movedir:
		if spritedir == "left" and test_move(transform, dir.left):
			anim_switch("push")
		if spritedir == "right" and test_move(transform, dir.right):
			anim_switch("push")
		if spritedir == "up" and test_move(transform, dir.up):
			anim_switch("push")
		if spritedir == "down" and test_move(transform, dir.down):
			anim_switch("push")
	elif movedir != Vector2(0, 0):
		anim_switch("walk")
	else:
		anim_switch("idle")
	
	if Input.is_action_pressed("a"):
		match role:
			0:
				use_weapon(preload("res://items/sword.tscn"))
			1:
				use_weapon(preload("res://items/crossbow.tscn"))
				fire_projectile(preload("res://items/bolt.tscn"))
			2:
				place_bomb(preload("res://items/bomb.tscn"))
			_:
				use_weapon(preload("res://items/sword.tscn"))
	if Input.is_action_pressed("b"):
		match role:
			0, 1, 2:
				pass
				# use_secondary()
			_:
				use_weapon(preload("res://items/crossbow.tscn"))
				fire_projectile(preload("res://items/bolt.tscn"))
	if Input.is_action_just_pressed("c"):
		match role:
			0, 1, 2:
				pass
			_:
				place_bomb(preload("res://items/bomb.tscn"))

func state_swing():
	anim_switch("idle")
	movement_loop()
	damage_loop()
	movedir = dir.center

func state_fire():
	anim_switch("idle")
	movement_loop()
	damage_loop()
	movedir = dir.center

func state_throw():
	anim_switch("idle")
	movement_loop()
	damage_loop()
	movedir = dir.center

func controls_loop():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)
