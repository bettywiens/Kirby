class EnergyBall extends Character
{
  AnimationImage flying;
  NormalImage flying_image;
  float flying_height;

  int direction_counter;
  String directions_path = "C:/Users/bwiens/Documents/GitHub/Kirby/KirbysAdventure/data/enemy/directions/energy_ball_directions.txt";
  String directions_string;
  char[] directions_array;

  EnergyBall(float pixel_x, float pixel_y, float speed)
  {
    super(GameTypes.ENEMY, pixel_x, pixel_y, speed, energy_ball_size);

    flying = new AnimationImage("enemy/flying", 4, ENERGY_BALL_ANIMATION_SPEED);

    flying_image = new NormalImage("enemy/flying_1.png");

    this.flying_height = flying_image.image_height;

    setImageContainer(flying);

    direction_counter = 0;

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
        }
        timer.start();
        direction_counter++;
      }
    }
  }

  void checkCollision()
  {
    CollisionResult collision_result = checkCollision();

    if (collision_result != null)
    {
      if (collision_result.type.equals(GameTypes.KIRBY_STAR))
      {
        println("collided :))");
      }
    }
  }

  @Override
    void update()
  {
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
}
