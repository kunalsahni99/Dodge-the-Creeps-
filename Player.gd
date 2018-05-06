extends Area2D

signal hit

export (int) var SPEED
var velocity = Vector2()
var screensize

func _ready():
	hide()
	screensize = get_viewport_rect().size
	
func start(pos):
	position = pos
	show()
	$Collision.disabled = false
			
func _process(delta):
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	_on_Left_pressed()
	_on_Right_pressed()
	_on_Up_pressed()
	_on_Down_pressed()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)

	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0

func _on_Player_body_entered( body ):
	$Collision.disabled = true
	hide()
	emit_signal("hit")

func _on_Left_pressed():
	if $GUI/Left.is_pressed():
		velocity.x -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

func _on_Right_pressed():
	if $GUI/Right.is_pressed():
		velocity.x += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

func _on_Up_pressed():
	if $GUI/Up.is_pressed():
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

func _on_Down_pressed():
	if $GUI/Down.is_pressed():
		velocity.y +=1
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()