extends CharacterBody2D

var player : CharacterBody2D
var direction : Vector2
var speed := 75.0
var health = 10
var dying := false

func _ready() -> void:
	player = get_node('/root/Game/playerV2') #this made the errors go away

func _physics_process(delta: float) -> void:
	if dying == false:
		velocity = (player.position - position).normalized() * speed
		move_and_collide(velocity * delta)

func take_damage(dmg:int) -> void:
	health -= dmg
	if (health <= 0):
		player.exp += 25
		$AnimatedSprite2D.animation = "die"
		$CollisionShape2D.disabled = true
		dying = true
		$Timer.start()

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	add_to_group("enemies")

func _on_timer_timeout() -> void:
	queue_free() #let them die
