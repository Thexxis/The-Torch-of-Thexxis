class_name entity
extends KinematicBody2D

export(int) var MAXHEALTH = 1
var TYPE = "ENEMY"
var SPEED = 0
var DAMAGE = 0

var movedir = Vector2(0, 0)
var knockdir = Vector2(0, 0)
var spritedir = "down"

export(int) var health = MAXHEALTH
var hitstun = 0
var texture_default = null
var texture_hurt = null

func _ready():
	if TYPE == "ENEMY":
		set_collision_mask_bit(1, 1)
		set_physics_process(false)
	texture_default = $Sprite.texture
	texture_hurt = load($Sprite.texture.get_path().replace(".png", "_hurt.png"))

func movement_loop():
	var motion
	if hitstun == 0:
		motion = movedir.normalized() * SPEED
	else:
		motion = knockdir.normalized() * 125
	move_and_slide(motion, Vector2(0, 0))

func spritedir_loop():
	match movedir:
		dir.left:
			spritedir = "left"
		dir.right:
			spritedir = "right"
		dir.up:
			spritedir = "up"
		dir.down:
			spritedir = "down"

func anim_switch(animation):
	var newanim = str(animation, spritedir)
	if $anim.current_animation != newanim:
		$anim.play(newanim)

func damage_loop():
	health = min(MAXHEALTH, health)
	if hitstun > 0:
		hitstun -= 1
		$Sprite.texture = texture_hurt
	else:
		$Sprite.texture = texture_default
		if TYPE == "ENEMY" && health <= 0:
			var drop = randi() % 4
			if drop == 0:
				instance_scene(preload("res://pickups/heart.tscn"))
			instance_scene(preload("res://enemies/enemy_death.tscn"))
			queue_free()
	for area in $hitbox.get_overlapping_areas():
		var body = area.get_parent()
		if hitstun == 0 && body.get("DAMAGE") != null && body.get("TYPE") != TYPE:
			health -= body.get("DAMAGE")
			hitstun = 10
			knockdir = global_transform.origin - body.global_transform.origin

func use_weapon(weapon):
	var newweapon = weapon.instance()
	newweapon.add_to_group(str(weapon, self))
	add_child(newweapon)
	if get_tree().get_nodes_in_group(str(weapon, self)).size() > newweapon.maxamount:
		newweapon.queue_free()

func fire_projectile(projectile):
	var newprojectile = projectile.instance()
	newprojectile.add_to_group(str(projectile, self))
	add_child(newprojectile)

func place_bomb(bomb):
	var newbomb = bomb.instance()
	newbomb.add_to_group(str(bomb, self))
	owner.add_child(newbomb)
	newbomb.global_position = global_position # + Vector2(0, 16)
	if get_tree().get_nodes_in_group(str(bomb, self)).size() > newbomb.maxamount:
		newbomb.queue_free()

func instance_scene(scene):
	var new_scene = scene.instance()
	new_scene.global_position = global_position
	get_parent().add_child(new_scene)
