class KirbyStar extends Star
{
  
  NormalImage star;
  String star_path = "star/kirby/star_1.png";
  
  KirbyStar(float pixel_x, float pixel_y, float speed)
  {
    super(pixel_x, pixel_y, speed);
    
    kirby_x = pixel_x;
    kirby_y = pixel_y;
    
    star = new NormalImage(star_path);
    
    setImageContainer(star);
    

  }
  
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
