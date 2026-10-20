class EnemyHealth extends Health
{ 
  String bar_path = "health/enemy/bar_";
  
  NormalImage health_bar;
  
  EnemyHealth(float pixel_x,float pixel_y,float size)
  {
    super(GameTypes.ENEMY_HEALTH, pixel_x, pixel_y, size, 28);
      
    health_bar = new NormalImage("health/enemy/bar_28.png");
    
    setImageContainer(health_bar);
  }
  
  void setHealthBar(int health)
  {
    NormalImage  health_bar_new = new NormalImage(bar_path + health + ".png");
    
    setImageContainer(health_bar_new);
  }
}
