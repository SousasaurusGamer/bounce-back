extends CharacterBody2D

# estadisticas de personaje
@export var speed: float = 130.0
@export var jump_velocity: float = -500.0

# Movimiento del personaje
func _physics_process(delta: float) -> void:

    # gravedad
    if not is_on_floor():
        velocity += get_gravity() * delta

    # salto
    if Input.is_action_just_pressed("ui_up") and is_on_floor():
        velocity.y = jump_velocity
    
    # Movimiento
    var direction = Input.get_axis("ui_left","ui_right")

    if direction != 0:
        velocity.x = direction * speed
    else:
        velocity.x = move_toward(
            velocity.x, 0, speed * 8 * delta 
        )

    move_and_slide()