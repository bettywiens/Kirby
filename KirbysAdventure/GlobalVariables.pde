class GlobalVariables
{  
  float STAR_ANIMATION_SPEED;
  float ENERGY_BALL_ANIMATION_SPEED;

  // Geschwindigkeiten
  float SPEED;
  float KIRBY_SPEED;
  float SHOOTING_STAR_SPEED;
  float SHOOTING_ENEMY_SPEED;
  float ENERGY_BALL_SPEED;



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



  float kirby_size;

  int kirby_lives;


  int live_number = 5;

  float live_size = 20;

  float energy_ball_start_x;
  float energy_ball_start_y;
  float energy_ball_size;

  float star_size;
  float lower_border;

  ArrayList<GameObject> game_objects;
  ArrayList<Integer> star_collided_with_kirby;

  GlobalVariables(float SCALE)
  {

    kirby_start_x = width * 0.1;
    kirby_start_y = height / 2;
    kirby_lives = 5;



    energy_ball_start_x = width - (width * 0.2);
    energy_ball_start_y = height / 2;


    STAR_ANIMATION_SPEED = 0.8;
    ENERGY_BALL_ANIMATION_SPEED = 1;

    // Geschwindigkeiten
    SPEED = 2 * SCALE;
    KIRBY_SPEED = 7.5 * SCALE;
    SHOOTING_STAR_SPEED = 25 * SCALE;
    SHOOTING_ENEMY_SPEED = 10 * SCALE;
    ENERGY_BALL_SPEED = 2.5 * SCALE;

    kirby_size = (images.kirby_image.image_height * SCALE) * 0.75;
    println(SCALE);
    energy_ball_size = (images.energy_ball_image.image_height * SCALE);

    star_size = images.star_image.image_height * 1.5;

    lower_border = height - sky_background.stats_bar_height;

    game_objects = new ArrayList<GameObject>();
    star_collided_with_kirby = new ArrayList<Integer>();
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
