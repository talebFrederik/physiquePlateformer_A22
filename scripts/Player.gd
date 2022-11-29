extends KinematicBody2D

export var speed = 100.0
export var jump_speed = 150.0
export var gravity = 250.0
var screen_size;
var on_ladder = false

var velocity = Vector2()

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	position.x = clamp(position.x,0,screen_size.x)

func _physics_process(delta):
	# on ne remet pas le vecteur de vélocité à 0 complètement
	# pour garder le déplacement vertical avec gravité
	velocity.x = 0
	if on_ladder:
		velocity.y = 0
	# qu'est-ce que l'utilisateur fait?
	get_input()
	# application de la gravité
	# il faut la multiplier par le temps écoulé depuis le dernier calcul
	# sinon on aura le déplacement pour une seconde complète
	if not on_ladder: 
		velocity.y += gravity * delta
	animate()
	velocity = move_and_slide(velocity, Vector2.UP)
	
	
	
func get_input():
	# on utilise un vecteur de la bonne longueur dès le début
	# parce qu'il faut appliquer des vitesses différente en x et en y
	# en plus ça simplifie le calcul pour la gravité
	if Input.is_action_pressed("right"):
		velocity.x += speed
	if Input.is_action_pressed("left"):
		velocity.x += -speed
	if Input.is_action_pressed("up") and on_ladder:
		velocity.y += -speed
	if Input.is_action_pressed("down") and on_ladder:
		velocity.y += speed
	# is_on_floor permet d'éviter le "double jump" à répétition
	# pour s'amuser on peut enlver cette partie de la condition et voir
	# le résultat
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += -jump_speed
		
func animate():
	if is_on_floor():
		if velocity.x > 0:
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("walk")
		elif velocity.x < 0:
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play("walk")
		else:
			$AnimatedSprite.play("default")
