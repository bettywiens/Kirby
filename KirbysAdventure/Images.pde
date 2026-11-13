class Images
{
  // IMAGES:
  // --- ENERGY BALL:
  NormalImage energy_ball_image;
  // --- KIRBY:
  NormalImage kirby_image;
  NormalImage kirby_flying;
  AnimationImage kirby_shooting;
  NormalImage kirby_health_bar;
  AnimationImage flying;
  NormalImage enemy_flying_image;
  AnimationImage enemy_damage;

  NormalImage health_bar_new;
  NormalImage enemy_health_bar;
  // --- STAR:
  NormalImage star_image;


  // MENÜ:
  AnimationImage game_over_background;
  AnimationImage background;
  AnimationImage won_background;
  NormalImage home_background;


  NormalImage game_end;
  NormalImage lives;
  NormalImage continue_image;
  NormalImage pointer;
  NormalImage try_again;
  NormalImage yes;
  NormalImage no;
  NormalImage selector;

  String lives_path;

  // PFADE:
  // --- ENEMY:
  String enemy_flying_path;  
  String energy_ball_burst_path;
  String enemy_star_path;

  String stats_bar_path;
  String sky_path;

  String kirby_bar_path;
  String kirby_star_path;

  String enemy_bar_path;

  String directions_path;

  String menu_numbers_path;

  Images()
  {
    enemy_flying_path = "enemy/flying/frame";

    energy_ball_image = new NormalImage("enemy/flying/frame_1.png");
    enemy_health_bar = new NormalImage("health/enemy/bar_28.png");

    kirby_image = new NormalImage("kirby/flying.png");
    star_image = new NormalImage("star/kirby/star_1.png");
    kirby_flying = new NormalImage("kirby/flying.png");
    kirby_shooting = new AnimationImage("kirby/shooting/shooting", 9, 0.8);
    kirby_health_bar = new NormalImage("health/kirby/bar_7.png");
    
    
    enemy_flying_image = new NormalImage(enemy_flying_path + "_1.png");
    enemy_damage = new AnimationImage("enemy/damage/frame", 4, 2);

    game_over_background = new AnimationImage("menu/game_over/frame", 5, 0.1);
    background = new AnimationImage("menu/background/frame", 7, 0.1);
    home_background = new NormalImage("menu/home/background.png");
    won_background = new AnimationImage("menu/won/", 25, 0.2);

    game_end = new NormalImage("menu/game_end.png");
    lives = new NormalImage("menu/lives.png");
    continue_image = new NormalImage("menu/continue.png");
    pointer = new NormalImage("menu/pointer.png");
    try_again = new NormalImage("menu/try_again.png");
    yes = new NormalImage("menu/yes.png");
    no = new NormalImage("menu/no.png");
    selector = new NormalImage("menu/home/selector.png");


    
    energy_ball_burst_path = "star/energy_ball/burst/frame";
    enemy_star_path = "star/energy_ball/purple_star/star";


    lives_path = "health/numbers/";
    stats_bar_path = "background/stats_bar.png";
    sky_path = "background/sky.png";
    enemy_bar_path = "health/enemy/bar_";

    kirby_bar_path = "health/kirby/bar_";
    kirby_star_path = "star/kirby/star";

    directions_path = "C:/Users/bwiens/Documents/GitHub/Kirby/KirbysAdventure/data/enemy/directions/energy_ball_directions.txt";

    menu_numbers_path = "menu/numbers/";
  }
}
