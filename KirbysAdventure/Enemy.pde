class Enemy extends Character
{
  int direction_counter;
  String directions_string;
  char[] directions_array;

  int counter = 0;

  boolean shooting_star = false;
  boolean shooting_burst = false;

  Timer enemy_timer;
  Timer damage_timer;

  Enemy(float pixel_x, float pixel_y, float speed, float size, int health)
  {
    super(GameTypes.ENEMY, pixel_x, pixel_y, speed, size, health);             

    direction_counter = 0;

    damage_timer = new Timer(500);
    
    enemy_timer = new Timer(2); // Timer 2ms für Bewegung
    enemy_timer.start();
  }

  void readFile(String directions_path)
  {
    // Lesen Datei mit Bewegungsinformationen und lagern diese in einem char Array
    try
    {
      directions_string = Files.readString(Path.of(directions_path));
      
    }
    catch (IOException e)
    {
      println("File not found");
    }

    directions_array = directions_string.toCharArray();
  }

  @Override
    void move()
  {
  }

  void checkCollisionWithStar()
  {

    CollisionResult collision_result = checkCollision(pixel_x, pixel_y, size);

    if (collision_result != null)
    {
      //println(collision_result.type);
      if (collision_result.type == GameTypes.KIRBY_STAR && !global.energy_ball_collided_with_star)
      {
        damage_timer.start();
        global.energy_ball_collided_with_star = true;
        global.energy_ball_damaged = true;
        health-=2;
        enemy_health.setHealthBar(health);
        if (health == 0)
        {
          global.game_playing = false;
          global.kirby_won = true;
        }
      }
    }
  }

  
    void update(AnimationImage enemy_damage, float flying_height, AnimationImage normal)
  {
    checkBorders(flying_height);
    checkCollisionWithStar();

    if (global.energy_ball_damaged)
    {
      setImageContainer(enemy_damage); // Anderes Bild festlegen für, wenn man den Energy Ball trifft
    } else
    {
      setImage(normal);
    }

    if (damage_timer.isFinished())
    {
      global.energy_ball_damaged = false;
      global.energy_ball_collided_with_star = false;
    }
  }


  void setImage(AnimationImage flying)
  {
    setImageContainer(flying);
  }

  void goUp()
  {
    pixel_y -= speed;
  }

  void goDown()
  {
    pixel_y += speed;
  }

  void goRight(int steps)
  {
    pixel_x += steps * speed;
  }

  void goLeft(int steps)
  {
    pixel_x -= steps * speed;
  }

  void goRightUp()
  {
    pixel_x += speed;
    pixel_y -= speed;
  }

  void goRightDown()
  {
    pixel_x += speed;
    pixel_y += speed;
  }

  void goLeftUp()
  {
    pixel_x -= speed;
    pixel_y -= speed;
  }

  void goLeftDown()
  {
    pixel_x -= speed;
    pixel_y += speed;
  }
  
}
