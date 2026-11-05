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

  EnergyBallStar star_1;
  EnergyBallStar star_2;
  EnergyBallStar star_3;

  int counter = 0;

  boolean shooting_star = false;

  EnergyBall(float pixel_x, float pixel_y, float speed)
  {
    super(GameTypes.ENEMY, pixel_x, pixel_y, speed, energy_ball_size, 28);

    flying = new AnimationImage("enemy/flying/frame", 4, ENERGY_BALL_ANIMATION_SPEED);

    flying_image = new NormalImage("enemy/flying/frame_1.png");

    damage = new AnimationImage("enemy/damage/frame", 4, 2);

    this.flying_height = flying_image.image_height;

    setImageContainer(flying);

    direction_counter = 0;

    // Energy Ball Stern:
    star_1 = new EnergyBallStar(energy_ball_x, energy_ball_y, SHOOTING_ENEMY_SPEED, "LEFT");
    star_1.size = star_size;
    game_objects.add(star_1);
    star_2 = new EnergyBallStar(energy_ball_x, energy_ball_y, SHOOTING_ENEMY_SPEED, "LEFT_UP");
    star_2.size = star_size;
    game_objects.add(star_2);
    star_3 = new EnergyBallStar(energy_ball_x, energy_ball_y, SHOOTING_ENEMY_SPEED, "LEFT_DOWN");
    star_3.size = star_size;
    game_objects.add(star_3);
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
          goRight();
        } else if (directions_array[direction_counter] == '3')
        {
          goLeft();
        } else if (directions_array[direction_counter] == 's')
        {
          star_1.resetStar(); // Bevor der Stern geschossen wird, wird seine Position geresettet
          star_2.resetStar();
          star_3.resetStar();
          shooting_star = true;
        }
        timer.start();
        direction_counter++;
      }
    }
  }

  void checkCollisionWithStar()
  {
    CollisionResult collision_result = checkCollision(pixel_x, pixel_y, "enemy");

    if (collision_result != null)
    {
      if (collision_result.type == GameTypes.KIRBY_STAR && !energy_ball_collided_with_star)
      {
        if (health == 0)
        {
          println("gewonnen");
          return;
        } else
        {
          energy_ball_collided_with_star = true;
          energy_ball_damaged = true;
          health-=2;
          enemy_health.setHealthBar(health);
        }
      }
    }
  }

  @Override
    void update()
  {
    // Wenn Stern außerhalb des Bildschirms ist
    if (star_1.pixel_x < 0)
    {
      shooting_star = false;
      kirby_collided_with_star = false;
      star_1.resetStar();
      star_2.resetStar();
      star_3.resetStar();
    }
    // Wenn Stern geschossen wird
    if (shooting_star == true)
    {
      // Wir schießen erst und zeichnen dann, damit der Stern nicht auf dem Energy Ball selbst gezeichnet wird
      star_1.shoot();
      star_2.shoot();
      star_3.shoot();
      star_1.drawObject();
      star_2.drawObject();
      star_3.drawObject();
    }
    if (energy_ball_damaged)
    {
      setImageContainer(damage); // Anderes Bild festlegen für, wenn man den Energy Ball trifft
    } else
    {
      setImage();
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

  void goRight()
  {
    pixel_x += speed;
  }

  void goLeft()
  {
    pixel_y -= speed;
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
