class Images
{
  // IMAGES:
  // --- ENERGY BALL:
  NormalImage energy_ball_image;
  // --- KIRBY:
  NormalImage kirby_image;
  // --- STAR:
  NormalImage star_image;
  
  String lives_path;
  
  // PFADE:
  // --- ENEMY:
  String enemy_flying_path;
  String enemy_damage_path;

  Images()
  {
    
    energy_ball_image = new NormalImage("enemy/flying/frame_1.png");
    kirby_image = new NormalImage("kirby/flying.png");
    star_image = new NormalImage("star/kirby/star_1.png");
    
    enemy_flying_path = "enemy/flying/frame";
    enemy_damage_path = "enemy/damage/frame";
    
    
    lives_path = "health/numbers/";
  }
}
