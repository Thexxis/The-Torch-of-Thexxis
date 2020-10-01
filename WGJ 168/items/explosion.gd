extends entity

func _ready():
	DAMAGE = 1
	TYPE = null
	$anim.play("default")
	$anim.connect("animation_finished", self, "destroy")

func destroy(animation):
	queue_free()
