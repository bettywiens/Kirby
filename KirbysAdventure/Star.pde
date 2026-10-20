class Star extends GameObject
{

  float speed;
  
  Star(float pixel_x, float pixel_y, float speed, GameTypes type)
  {
    super(type, pixel_x, pixel_y);    
    this.speed = speed;
  }
  
  void shoot()
  {
  }
  
}
