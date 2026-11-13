class Kirby extends Character
{
  float flying_height; // Höhe des Bildes

  boolean shooting_star = false;

  boolean space_pressed = false;

  int health_counter = 0;


  Kirby(float pixel_x, float pixel_y, float speed)
  {
    super(GameTypes.KIRBY, pixel_x, pixel_y, speed, global.kirby_size, 7);   
    

    flying_height = images.kirby_flying.image_height;

    // Animation wenn Kirby einen Stern schießt
    

    setImageContainer(images.kirby_flying);
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
      setImageContainer(images.kirby_shooting); // Anderes Bild für wenn Kirby schießt
      global.game_objects.add(new KirbyStar(pixel_x, pixel_y, global.SHOOTING_STAR_SPEED)); // jedes mal wenn geschossen wird, wird ein neuer Stern erstellt      
    } else if (key_handler.e_pressed)
    {
      //println("e pressed");
      global.menu_open = true;
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
      // Wenn Kirby mit einem Stern kollidiert, mit dem er nicht bereits kollidiert ist:
      if (collision_result.type == GameTypes.ENEMY_STAR && !global.star_collided_with_kirby.contains(collision_result.id))
      {
        // Wenn noch Healthpunkte vorhanden sind verlieren wir einen
        if (health > 0)
        {                    
          health--;
          kirby_health.setHealthBar(health);
          // Wir laden den Stern mit dem wir kollidiert sind in eine Liste, um keine weitere Kollision
          // mit dem gleichen Stern zu verursachen
          global.star_collided_with_kirby.add(collision_result.id); 
          
          if (health == 0 && !global.live_lost) // Wie kommen wir hier rein?
          {
            global.kirby_lives--;
            global.live_lost = true;
            global.try_again_open = true;
          }
        }       
      }
    } 
  }

  // Setzt Kirbys default image
  void setImage()
  {
    setImageContainer(images.kirby_flying);
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
