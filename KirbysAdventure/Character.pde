class Character extends GameObject
{
  float speed;
  
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
  
  void update()
  {
  }
}
