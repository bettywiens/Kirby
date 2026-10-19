class Star extends GameObject
{

  float speed;
  
  Star(float pixel_x, float pixel_y, float speed)
  {
    super(GameTypes.STAR, pixel_x, pixel_y);    
    this.speed = speed;
  }
  
  void shoot()
  {
  }
  
}
