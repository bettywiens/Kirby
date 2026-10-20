class Star extends GameObject
{

  float speed;
  
  Star(float pixel_x, float pixel_y, float speed, GameTypes type, float size)
  {
    super(type, pixel_x, pixel_y, size);    
    this.speed = speed;
  }
  
  void shoot()
  {
  }
  
}
