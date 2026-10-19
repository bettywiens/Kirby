class EnergyBall extends Character
{

  NormalImage flying;
  float flying_height;

  EnergyBall(float pixel_x, float pixel_y, float speed)
  {
    super(GameTypes.ENEMY, pixel_x, pixel_y, speed);
    
    flying = new NormalImage("enemy/flying_1.png");
    
    this.flying_height = flying.image_height;
    

    setImageContainer(flying);
  }

  @Override
    void move()
  {
    if (key_handler.w_pressed || key_handler.up_pressed)
    {
      goUp();
    } else if (key_handler.s_pressed || key_handler.down_pressed)
    {
      goDown();
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
    pixel_y -= speed + randomOffset(30);
  }

  void goDown()
  {
    pixel_y += speed + randomOffset(30);
  }
  
  float randomOffset(float random_number)
  {
    return random(random_number);  
  }
}
