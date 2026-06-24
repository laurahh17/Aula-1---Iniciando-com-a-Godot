extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var hud: CanvasLayer = $"../hud"
@onready var posicao_inicial: Marker2D = $"../PosicaoInicial"

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
# Altera a animação
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("walk")
	else:
		animated_sprite_2d.play("jump")

	move_and_slide()
	
func die():
	tomar_dano(1)
	get_tree().reload_current_scene()
# função que recebe a quantidade de dano via parâmetro e aplica à vidas

func tomar_dano(dano:int) -> void:
	GameManager.vidas -= dano
	if GameManager.vidas <= 0:
		print("Game Over")
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	else:
		respawn() #função respawn chamada
	hud.atualizar_vidas()
	
# função que reposiciona o personagem na posição do Marker2D
func respawn() -> void:
	position = posicao_inicial.position
