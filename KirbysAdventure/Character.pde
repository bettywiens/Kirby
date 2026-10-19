class Character extends GameObject
{
  float speed;
  float character_height;
  
  Character(GameTypes type, float pixel_x, float pixel_y, float speed)
  {
    super(type, pixel_x, pixel_y);
    this.speed = speed;    
  }
  
  void move()
  {
  }
  
  CollisionResult checkCollision()
  {
    CollisionResult result = new CollisionResult();
    return result;
   
  }
  
  void checkBorders(float image_height)
  {
    if(pixel_y <= 0 + character_height)
    {
      pixel_y = 0 + character_height;
    } else if (pixel_y >= lower_border - image_height * SCALE)
    {
      pixel_y = lower_border - image_height * SCALE;
    }
    
    
  }
  
  void update()
  {
  }
}
