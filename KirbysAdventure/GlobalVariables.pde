class GlobalVariables
{
  float kirby_start_x;
  float kirby_start_y;
  float kirby_size;
  

  float kirby_health_x;
  float kirby_health_y;
  int kirby_lives;
  
  float energy_ball_start_x;
  float energy_ball_start_y;
  float energy_ball_health_x;
  float energy_ball_health_y;
  float energy_ball_size;

  int SCALE;
  float STAR_ANIMATION_SPEED;
  float ENERGY_BALL_ANIMATION_SPEED;

  // Geschwindigkeiten
  int SPEED;
  int KIRBY_SPEED;
  int SHOOTING_STAR_SPEED;
  int SHOOTING_ENEMY_SPEED;
  int ENERGY_BALL_SPEED;

  float star_size;
  float lower_border;

  GlobalVariables()
  {
    kirby_start_x = 100;
    kirby_start_y = 200;
    kirby_lives = 5;    

    kirby_health_y = 495;
    kirby_health_x = 200;
    
    energy_ball_start_x = 600;
    energy_ball_start_y = 200;
    energy_ball_health_x = 200;
    energy_ball_health_y = 537;

    SCALE = 2;
    STAR_ANIMATION_SPEED = 0.8;
    ENERGY_BALL_ANIMATION_SPEED = 1;

    // Geschwindigkeiten
    SPEED = 4;
    KIRBY_SPEED = 15;
    SHOOTING_STAR_SPEED = 50;
    SHOOTING_ENEMY_SPEED = 20;
    ENERGY_BALL_SPEED = 5;
    
    kirby_size = (images.kirby_image.image_height * SCALE) * 0.66;
    energy_ball_size = (images.energy_ball_image.image_height * SCALE);

    star_size = images.star_image.image_height * 1.5;

    lower_border = height - sky_background.stats_bar_height;
  }
}
