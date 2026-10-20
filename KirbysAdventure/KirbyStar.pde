class KirbyStar extends Star
{
  
  AnimationImage star;
  NormalImage star = new NormalImage("star/kirby/star_1.png");
  
  
  KirbyStar(float pixel_x, float pixel_y, float speed)
  {
    super(GameTypes.KIRBY_STAR, pixel_x, pixel_y, speed, star.image_height);
    
    kirby_x = pixel_x;
    kirby_y = pixel_y;
    
    star = new AnimationImage("star/kirby/star", 8, STAR_ANIMATION_SPEED);
    
    setImageContainer(star);
  }
  
  // Schießt Stern von
  void shoot()
  {
    pixel_y = kirby_y;
    pixel_x += speed;    
  }
  
  void resetStar()
  {
    pixel_x = kirby_x;
    pixel_y = kirby_y;
  }
}
