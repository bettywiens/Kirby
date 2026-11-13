class EnergyBallStar extends Star
{  
  AnimationImage star;     
  String direction;
  
  
  EnergyBallStar(float pixel_x, float pixel_y, float speed, String direction)
  {
    super(pixel_x, pixel_y, speed, GameTypes.ENEMY_STAR, global.star_size);
    
    this.direction = direction;
    pixel_x = energy_ball.pixel_x;
    pixel_y = energy_ball.pixel_y;
    
    star = new AnimationImage("star/energy_ball/purple_star/star", 8, global.STAR_ANIMATION_SPEED);    
    
    setImageContainer(star);    

  }
  
  // Schießt Stern von Kirby aus in Richtung gegner
  void shoot()
  {
    switch (direction)
    {
      case "LEFT":
        pixel_x -= speed;
        break;
      case "LEFT_UP":
        pixel_x -= speed;
        pixel_y -= speed/3;
        break;
      case "LEFT_DOWN":
        pixel_y += speed/3;
        pixel_x -= speed;
        break;
    }    
  }
  
  void resetStar()
  {    
    pixel_x = energy_ball.pixel_x;
    pixel_y = energy_ball.pixel_y;
    //println("kirby collided with star = false");
  }
  
  @Override
  boolean checkIfOutside()
  {
    if (pixel_x < 0)
    {
      return true;
    } else
    {
      return false;
    }
  }
}
