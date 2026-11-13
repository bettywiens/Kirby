class EnergyBall extends Character
{
  AnimationImage flying;
  NormalImage flying_image;
  AnimationImage damage;
  float flying_height;

  int direction_counter;
  String directions_path = "C:/Users/bwiens/Documents/GitHub/Kirby/KirbysAdventure/data/enemy/directions/energy_ball_directions.txt";
  String directions_string;
  char[] directions_array;

  int counter = 0;

  boolean shooting_star = false;
  boolean shooting_burst = false;

  Timer damage_timer;

  EnergyBall(float pixel_x, float pixel_y, float speed)
  {
    super(GameTypes.ENEMY, pixel_x, pixel_y, speed, global.energy_ball_size, 28);

    flying = new AnimationImage(images.enemy_flying_path, 4, global.ENERGY_BALL_ANIMATION_SPEED);

    flying_image = new NormalImage(images.enemy_flying_path + "_1.png");

    damage = new AnimationImage(images.enemy_damage_path, 4, 2);

    this.flying_height = flying_image.image_height;

    setImageContainer(flying);

    direction_counter = 0;

    damage_timer = new Timer(500);
  }

  void readFile()
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
    readFile();
    checkCollisionWithStar();


    // Wenn Timer vorbei ist bewegt sich EnergyBall abhängig von der direction nach oben oder unten
    if (timer.isFinished())
    {
      // Wenn der counter die Länge der Datei überschreitet wird er zurückgesetzt
      if (direction_counter >= directions_array.length)
      {
        direction_counter = 0;
      } else
      {
        if (directions_array[direction_counter] == '0')
        {
          goUp();
        } else if (directions_array[direction_counter] == '1')
        {
          goDown();
        } else if (directions_array[direction_counter] == '2')
        {
          goRight(1);
        } else if (directions_array[direction_counter] == '3')
        {
          goLeft(1);
        } else if (directions_array[direction_counter] == 's')
        {
          game_objects.add(new EnergyBallStar(pixel_x, pixel_y, global.SHOOTING_ENEMY_SPEED, "LEFT_UP"));
          game_objects.add(new EnergyBallStar(pixel_x, pixel_y, global.SHOOTING_ENEMY_SPEED, "LEFT"));
          game_objects.add(new EnergyBallStar(pixel_x, pixel_y, global.SHOOTING_ENEMY_SPEED, "LEFT_DOWN"));
          shooting_star = true;
        } else if (directions_array[direction_counter] == 'b')
        {
          game_objects.add(new EnergyBallBurst(pixel_x, pixel_y, global.SHOOTING_ENEMY_SPEED, "LEFT"));
          shooting_burst = true;
        }
        timer.start();
        direction_counter++;
      }
    }
  }

  void checkCollisionWithStar()
  {

    CollisionResult collision_result = checkCollision(pixel_x, pixel_y, size);

    if (collision_result != null)
    {
      //println(collision_result.type);
      if (collision_result.type == GameTypes.KIRBY_STAR && !energy_ball_collided_with_star)
      {
        damage_timer.start();
        energy_ball_collided_with_star = true;
        energy_ball_damaged = true;
        health-=2;
        enemy_health.setHealthBar(health);
        if (health == 0)
        {
          game_playing = false;
          kirby_won = true;
        }
      }
    }
  }

  @Override
    void update()
  {
    checkBorders(flying_height);
    checkCollisionWithStar();

    if (energy_ball_damaged)
    {
      setImageContainer(damage); // Anderes Bild festlegen für, wenn man den Energy Ball trifft
    } else
    {
      setImage();
    }

    if (damage_timer.isFinished())
    {
      energy_ball_damaged = false;
      energy_ball_collided_with_star = false;
    }
  }


  void setImage()
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
