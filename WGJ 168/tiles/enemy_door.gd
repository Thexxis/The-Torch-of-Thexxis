extends StaticBody2D

onready var camera = get_node("../camera")
onready var player = get_node("../player")

func _ready():
	$anim.play("open")
	$CollisionShape2D.disabled = true
	# $Sprite.visible = false

func _process(delta):
	if camera.grid_pos == camera.get_grid_pos(global_position):
		if camera.get_enemies() <= 0:
			if $anim.assigned_animation != "open":
				$anim.play("open")
				$CollisionShape2D.disabled = true
		elif !$area.get_overlapping_bodies().has(player):
			if $anim.assigned_animation != "close":
				$anim.play("close")
				$CollisionShape2D.disabled = false
	else:
		if $anim.assigned_animation != "open":
			$anim.play("open")
			$CollisionShape2D.disabled = true
