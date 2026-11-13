class GlobalVariables
{
  float SCALE = 2;
  float STAR_ANIMATION_SPEED;
  float ENERGY_BALL_ANIMATION_SPEED;

  // Geschwindigkeiten
  int SPEED;
  int KIRBY_SPEED;
  int SHOOTING_STAR_SPEED;
  int SHOOTING_ENEMY_SPEED;
  int ENERGY_BALL_SPEED;
  

  
  boolean energy_ball_collided_with_star = false;
  boolean kirby_collided_with_star = false;
  boolean energy_ball_damaged = false;
  boolean live_lost = false;
  boolean game_over = false;
  boolean menu_open = false;
  boolean try_again_open = false;
  boolean home_open = true;
  boolean game_playing = false;
  boolean kirby_won = false;

  float kirby_start_x;
  float kirby_start_y;
  
  float kirby_health_x;
  float kirby_health_y;
  
  float kirby_size;
  
  int kirby_lives;
  float kirby_lives_x;
  float kirby_lives_y;
  
  int live_number = 5;
  
  float live_size = 20;

  float energy_ball_start_x;
  float energy_ball_start_y;
  float energy_ball_health_x;
  float energy_ball_health_y;
  float energy_ball_size;

  float star_size;
  float lower_border;

  ArrayList<GameObject> game_objects;
  ArrayList<Integer> star_collided_with_kirby;

  GlobalVariables()
  {
    kirby_start_x = width * 0.1;
    kirby_start_y = height / 2;
    kirby_lives = 5;

    kirby_health_x = 200;
    kirby_health_y = sky_background.sky_height + (0.23 * sky_background.stats_bar_height);
    
    kirby_lives_x = 690;
    kirby_lives_y = sky_background.sky_height + (0.39 * sky_background.stats_bar_height);

    energy_ball_start_x = width - (width * 0.2);
    energy_ball_start_y = height / 2;
    energy_ball_health_x = 200;
    energy_ball_health_y = sky_background.sky_height + (0.53 * sky_background.stats_bar_height);
    
    STAR_ANIMATION_SPEED = 0.8;
    ENERGY_BALL_ANIMATION_SPEED = 1;

    // Geschwindigkeiten
    SPEED = 4;
    KIRBY_SPEED = 15;
    SHOOTING_STAR_SPEED = 50;
    SHOOTING_ENEMY_SPEED = 20;
    ENERGY_BALL_SPEED = 5;

    kirby_size = (images.kirby_image.image_height * SCALE) * 0.75;
    energy_ball_size = (images.energy_ball_image.image_height * SCALE);

    star_size = images.star_image.image_height * 1.5;

    lower_border = height - sky_background.stats_bar_height;

    game_objects = new ArrayList<GameObject>();
    star_collided_with_kirby = new ArrayList<Integer>();
  }
  
  void setScale(float scale)
  {
    this.SCALE = scale;
  }
  
  void init()
  {
    game_objects = new ArrayList<GameObject>();
    star_collided_with_kirby = new ArrayList<Integer>();
  }
  
  void resetLives()
  {
    kirby_lives = live_number;
  }
}
