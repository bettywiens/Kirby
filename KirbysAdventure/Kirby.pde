class Kirby extends Character
{
  NormalImage flying;
  
  AnimationImage shooting;
  
  float flying_height;
 
  boolean shooting_star = false;
  
  
  
  
  Kirby(float pixel_x, float pixel_y, float speed)
  {
    super(GameTypes.KIRBY, pixel_x, pixel_y, speed);
    
    flying = new NormalImage("kirby/flying.png");
    
    shooting = new AnimationImage("kirby/shooting/shooting", 9, 0.8);
    
    flying_height = flying.image_height;
    
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
    } else if (key_handler.space_pressed)
    {
      setImageContainer(shooting);
      kirby_star.resetStar();
      shooting_star = true;
      
    } else if (!key_handler.space_pressed)
    {      
      setImageContainer(flying);
          
    }
    
    
    
  }
  
  @Override
  void update()
  {    
    if (kirby_star.pixel_x > width){
      shooting_star = false;
      kirby_star.resetStar();
    }
    if (shooting_star == true)
    {
      kirby_star.drawObject();      
      
      kirby_star.shoot();
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
}
