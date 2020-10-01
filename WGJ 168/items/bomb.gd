extends entity

var maxamount = 1

func _init():
	TYPE = null
	DAMAGE = null

func _ready():
	$anim.play("default")
	$anim.connect("animation_finished", self, "destroy")
	$CollisionShape2D.disabled = true

func _physics_process(delta):
	if $area.get_overlapping_bodies() == []:
		$CollisionShape2D.disabled = false

func destroy(animation):
	instance_scene(preload("res://items/explosion.tscn"))
	queue_free()
