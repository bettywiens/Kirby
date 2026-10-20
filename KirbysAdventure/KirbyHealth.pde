class KirbyHealth extends Health
{ 
  String bar_path = "health/kirby/bar_";
  
  NormalImage health_bar;
  
  KirbyHealth(float pixel_x,float pixel_y,float size)
  {
    super(GameTypes.ENEMY_HEALTH, pixel_x, pixel_y, size, 7);
      
    health_bar = new NormalImage("health/kirby/bar_7.png");
    
    setImageContainer(health_bar);
  }
  
  void setHealthBar(int health)
  {
    NormalImage  health_bar_new = new NormalImage(bar_path + health + ".png");
    
    setImageContainer(health_bar_new);
  }
}
