extends CharacterBody2D

# estadisticas de personaje
@export var max_health: int = 40 
@export var speed: float = 130.0
@export var jump_velocity: float = -500.0

# Movimiento del personaje
func _physics_process(delta: float) -> void:

    if Input.is_action_just_pressed("ui_down"):
        _take_damage(10)

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
    
     # Prueba temporal de daño
    if Input.is_action_just_pressed("ui_down"):
        recibir_danio(10)


# RECIBIR DAÑO
func recibir_danio(cantidad: int) -> void:
    if current_health <= 0:
        return

    current_health = max(current_health - cantidad, 0)

    print("Vida de Brayan: ", current_health)

    if current_health == 0:
        morir()


# MUERTE DEL PERSONAJE
func morir() -> void:
    print("Brayan ha muerto")