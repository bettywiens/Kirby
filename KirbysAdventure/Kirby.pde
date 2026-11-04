class Kirby extends Character
{
  NormalImage flying;

  AnimationImage shooting;

  float flying_height; // Höhe des Bildes

  boolean shooting_star = false;  

  Kirby(float pixel_x, float pixel_y, float speed)
  {
    super(GameTypes.KIRBY, pixel_x, pixel_y, speed, kirby_size, 7);

    flying = new NormalImage("kirby/flying.png");

    flying_height = flying.image_height;

    // Animation wenn Kirby einen Stern schießt
    shooting = new AnimationImage("kirby/shooting/shooting", 9, 0.8);

    setImageContainer(flying);
  }

  @Override
    void move()
  {
    kirby_health.setHealthBar(health);    
    checkCollisionWithStar();
    if (key_handler.w_pressed || key_handler.up_pressed)
    {      
      goUp();
    } else if (key_handler.s_pressed || key_handler.down_pressed)
    {
      goDown();
    } else if (key_handler.space_pressed)
    {      
      setImageContainer(shooting); // Anderes Bild für wenn Kirby schießt
      kirby_star.resetStar(); // Bevor der Stern geschossen wird, wird seine Position geresettet
      shooting_star = true;
    } else if (!key_handler.space_pressed)
    {
      //checkCollisionWithStar();
      setImage();
    }
  }

  @Override
    void update()
  {
    checkCollisionWithStar();
    // Wenn Stern außerhalb des Bildschirms ist
    if (kirby_star.pixel_x > width)
    {
      energy_ball_damaged = false;
      shooting_star = false;
      kirby_star.resetStar();
    }
    // Wenn Stern geschossen wird
    if (shooting_star == true)
    {
      // Wir schießen erst und zeichnen dann, damit der Stern nicht auf Kirby selbst gezeichnet wird
      kirby_star.shoot();
      kirby_star.drawObject();
    }
  }

  void checkCollisionWithStar()
  {    
    CollisionResult collision_result = checkCollision(pixel_x, pixel_y, "kirby");

    if (collision_result != null)
    {      
      if (collision_result.type == GameTypes.ENEMY_STAR && !kirby_collided_with_star)
      {
        if (health < 0)
        {
          println("gewonnen");
          return;
        } else
        {
          kirby_collided_with_star = true;
          health--;
          kirby_health.setHealthBar(health);
          println("Kirby Ball Health: " + health);
        }
      }
    }
  }

  // Setzt Kirbys default image
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
