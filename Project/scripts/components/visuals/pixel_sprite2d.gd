@tool
class_name PixelSprite2D
extends Sprite2D
## A Sprite2D with default settings for pixel art textures


# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.is_editor_hint():
		texture_changed.connect(_set_filter)


## Set the filter to nearest
func _set_filter():
	texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
