class_name Health
extends Component
## A component that keeps track of an actor's health (and more information for scaling)

signal drained ## Emitted when the health is set to zero
signal maxed ## Emitted when the health is set to the max value
signal changed ## Emitted when the health is changed to a NEW value
signal overmaxed ## Emitted when the health is changed to a value above the max

@export var max_health: int = 3
var value: int:
	get:
		return health
	set(new_value):
		health = new_value
		value = health
var health: int = max_health:
	set(value):
		var old_value = health
		health = clamp(value, 0, max_health)
		if not old_value == health:
			changed.emit()
		if value == 0:
			drained.emit()
		elif value > max_health:
			overmaxed.emit()
		elif value == max_health:
			maxed.emit()

var alive: bool: ## Returns true if the health is greater than zero
	get:
		return health > 0


## Increase the health by the specified value or 1 if none specified
func increase(amount: int = 1):
	health += amount


## Decrease the health by the specified value or 1 if none specified
func decrease(amount: int = 1):
	health -= amount
