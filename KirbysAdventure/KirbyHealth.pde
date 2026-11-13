class KirbyHealth extends Health
{ 
  KirbyHealth(float pixel_x,float pixel_y,float size)
  {
    super(GameTypes.ENEMY_HEALTH, pixel_x, pixel_y, size, 7); 
    
    setImageContainer(images.kirby_health_bar);
  }
  
  void setHealthBar(int health)
  {
    NormalImage  health_bar_new = new NormalImage(images.kirby_bar_path + health + ".png");
    
    setImageContainer(health_bar_new);
  }
}
