extends CanvasLayer

@onready var health_label: Label = $Control/HealthLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	atualizar_vidas()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func atualizar_vidas() -> void:
	health_label.text = "Vidas: " + str(GameManager.vidas)
