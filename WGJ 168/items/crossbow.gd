extends Node2D

var TYPE = null
const DAMAGE = 1

var maxamount = 1

func _ready():
	TYPE = get_parent().TYPE
	$anim.connect("animation_finished", self, "destroy")
	$anim.play(str("fire", get_parent().spritedir))
	if get_parent().has_method("state_fire"):
		get_parent().state = "fire"

func destroy(animation):
	if get_parent().has_method("state_fire"):
		get_parent().state = "default"
	queue_free()
