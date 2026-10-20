class Health extends GameObject
{
  int health;
  
  Health(GameTypes type, float pixel_x, float pixel_y, float size, int health)
  {
    super(type, pixel_x, pixel_y, size);
    this.health = health;            
  }
  
  
}
