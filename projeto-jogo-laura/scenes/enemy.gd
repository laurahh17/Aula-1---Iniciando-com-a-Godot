extends CharacterBody2D

const JUMP_VELOCITY = -400.0
const SPEED = 80.0
const GRAVITY = 800.0
var direction = 1
@onready var floor_left: RayCast2D = $FloorLeft
@onready var floor_right: RayCast2D = $FloorRight
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

	
func _physics_process(delta):
	# Gravidade — se não está no chão, aplica aceleração vertical
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Direção do movimento — detecta colisão nos sensores laterais
	if not floor_left.is_colliding():
		direction = 1
	elif not floor_right.is_colliding():
		direction = -1
	# Se ambos estiverem colidindo, mantém a direção anterior (não altera)

	# Aplica velocidade horizontal
	velocity.x = direction * SPEED

	# Vira a animação conforme a direção
	anim.flip_h = direction > 0

	# Toca a animação de caminhada (pode ser melhor usar um flag para não repetir)
	anim.play("walk")

	# Move o personagem
	move_and_slide()
