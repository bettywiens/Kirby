class Kirby extends Character
{
  NormalImage flying;

  AnimationImage shooting;

  float flying_height; // Höhe des Bildes

  boolean shooting_star = false;
  
  int counter = 0;


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
    } else if (key_handler.e_pressed)
    {
      println("e pressed");
      menu_open = true;
    } else if (!key_handler.space_pressed)
    {      
      setImage();
    }
  }

  @Override
    void update()
  {

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
      if (collision_result.type == GameTypes.ENEMY_STAR)
      {
        println("!! collided with projectile");
      }
      if (collision_result.type == GameTypes.ENEMY_STAR && !kirby_collided_with_star)
      {
        println("collision");
        if (health > 0)
        {
          kirby_collided_with_star = true;
          health--;
          println("HEALTH: " + health);
          kirby_health.setHealthBar(health);
          if (health == 0 && !live_lost)
          {
            println("HEALTH = 0");
            kirby_lives--;
            live_lost = true;
            try_again_open = true;
          }
        }
        // Sobald Kirbys Kollision mit dem Star endet:
      } else if (collision_result.type != GameTypes.ENEMY_STAR) {
        kirby_collided_with_star = false;
      }
    } else 
    {
      kirby_collided_with_star = false;
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
