class EnergyBallBurst extends Star
{     
  AnimationImage burst;
  String direction;
  
  
  EnergyBallBurst(float pixel_x, float pixel_y, float speed, String direction)
  {
    super(pixel_x, pixel_y, speed, GameTypes.ENEMY_STAR, global.star_size);
    
    this.direction = direction;
    pixel_x = energy_ball.pixel_x;
    pixel_y = energy_ball.pixel_y;
        
    burst = new AnimationImage(images.energy_ball_burst_path, 6, global.STAR_ANIMATION_SPEED);
    
    setImageContainer(burst);    

  }
  
  // Schießt Burst von Kirby aus in Richtung gegner
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
  
// !!! Funktion kann in Stern Klasse gepackt werden
  void resetStar()
  {    
    pixel_x = energy_ball.pixel_x;
    pixel_y = energy_ball.pixel_y;    
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
