@tool
class_name PixelSprite2D
extends Sprite2D
## A Sprite2D with default settings for pixel art textures

@export var resize_to_unit: bool = false: ## Click to resize the sprite to 0.3x
	set(value):
		scale = Vector2(0.3, 0.3)


# Called when the node enters the scene tree for the first time.
func _enter_tree():
	if Engine.is_editor_hint():
		if not texture_changed.is_connected(_set_filter):
			texture_changed.connect(_set_filter)


## Set the filter to nearest
func _set_filter():
	#texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	pass
