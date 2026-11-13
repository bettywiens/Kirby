class EnemyHealth extends Health
{     
  EnemyHealth(float pixel_x,float pixel_y,float size)
  {
    super(GameTypes.ENEMY_HEALTH, pixel_x, pixel_y, size, 28);          
    
    setImageContainer(images.enemy_health_bar);
  }
  
  void setHealthBar(int health)
  {
    NormalImage health_bar_new = new NormalImage(images.enemy_bar_path + health + ".png");
    
    setImageContainer(health_bar_new);
  }
}
