 class KirbyStar extends Star
{  
  AnimationImage star;    
  
  KirbyStar(float pixel_x, float pixel_y, float speed)
  {
    super(pixel_x, pixel_y, speed, GameTypes.KIRBY_STAR, global.star_size);
    
    kirby.pixel_x = pixel_x;
    kirby.pixel_y = pixel_y;
    
    star = new AnimationImage("star/kirby/star", 8, global.STAR_ANIMATION_SPEED);
    
    setImageContainer(star);    
  }
  
  // Schießt Stern von Kirby aus in Richtung gegner
  @Override
  void shoot()
  {    
    //pixel_y = kirby_y;
    //println("STAR X || " + pixel_x);
    pixel_x += speed;    
  }
  
  @Override
  void resetStar()
  {
    energy_ball_collided_with_star = false;
    pixel_x = kirby.pixel_x;
    pixel_y = kirby.pixel_y;
  }
  
  @Override
  boolean checkIfOutside()
  {
    if (pixel_x > width)
    {
      return true;
    } else
    {
      return false;
    }
  }
}
