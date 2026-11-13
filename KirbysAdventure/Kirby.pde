class Kirby extends Character
{
  NormalImage flying;

  AnimationImage shooting;

  float flying_height; // Höhe des Bildes

  boolean shooting_star = false;

  boolean space_pressed = false;

  int health_counter = 0;


  Kirby(float pixel_x, float pixel_y, float speed)
  {
    super(GameTypes.KIRBY, pixel_x, pixel_y, speed, global.kirby_size, 7);

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
      space_pressed = true;
    } else if (!key_handler.space_pressed && space_pressed)
    {
      space_pressed = false;
      setImageContainer(shooting); // Anderes Bild für wenn Kirby schießt
      game_objects.add(new KirbyStar(pixel_x, pixel_y, global.SHOOTING_STAR_SPEED)); // jedes mal wenn geschossen wird, wird ein neuer Stern erstellt
      //println("GAME OBJECTS SIZE || " + game_objects.size());
      //println(game_objects.get(game_objects.size()-1).getType());
    } else if (key_handler.e_pressed)
    {
      //println("e pressed");
      menu_open = true;
    } else if (!key_handler.space_pressed)
    {
      setImage();
    }
  }

  @Override
    void update()
  {
    checkBorders(flying_height);

    checkCollisionWithStar();
  }

  void checkCollisionWithStar()
  {
    CollisionResult collision_result = checkCollision(pixel_x, pixel_y, size);
    //println(kirby_collided_with_star);


    if (collision_result != null)
    {
      if (collision_result.type == GameTypes.ENEMY_STAR)
      {
        //println("!! collided with projectile");
      }
      if (collision_result.type == GameTypes.ENEMY_STAR && !kirby_collided_with_star)
      {
        health_counter++;
        println("collision" + health_counter);
        if (health > 0)
        {          
          kirby_collided_with_star = true;
          health--;
          kirby_health.setHealthBar(health);
          
          if (health == 0 && !live_lost)
          {
            global.kirby_lives--;
            live_lost = true;
            try_again_open = true;
          }
        }
        // Sobald Kirbys Kollision mit dem Star endet:
      } else if (collision_result.type != GameTypes.ENEMY_STAR) {
        println("ZURÜCKGESETZT");
        kirby_collided_with_star = false;        
      }
    } else
    {
      //println("ZURÜCKGESETZT");
      //kirby_collided_with_star = false;      
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
