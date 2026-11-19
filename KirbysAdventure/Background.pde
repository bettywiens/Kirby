class Background
{
  PImage sky_1;
  PImage sky_2;
  PImage stats_bar;
  PImage lives_box;
  PImage health_box;
  PImage kirby_name;
  PImage enemy_name;
  PImage kirby_multiplier;

  float sky_1_x = 0;
  float sky_2_x = width;

  float stats_bar_height;
  float sky_height;
  float stats_bar_y;
  float lives_box_x;
  float lives_box_y;

  float energy_ball_health_x;
  float energy_ball_health_y;

  float kirby_health_x;
  float kirby_health_y;

  float kirby_lives_x;
  float kirby_lives_y;



  Background()
  {
    sky_1 = loadImage(images.sky_path);
    sky_2 = loadImage(images.sky_path);
    stats_bar = loadImage(images.stats_bar_path);
    lives_box = loadImage(images.lives_box_path);
    health_box = loadImage(images.health_box_path);
    kirby_name = loadImage(images.kirby_name_path);
    enemy_name = loadImage(images.enemy_name_path);
    kirby_multiplier = loadImage(images.kirby_multiplier_path);

    stats_bar_height = (sky_1.height * SCALE) / 14 ;
    stats_bar_y = height - stats_bar_height;
    sky_height = height - stats_bar_height;
    lives_box_x =  width - images.lives_box_width;

    energy_ball_health_x = images.health_box_width / 2;
    energy_ball_health_y = sky_height + (0.53 * stats_bar_height);

    kirby_health_x = images.health_box_width / 2;
    kirby_health_y = sky_height + (0.23 * stats_bar_height);

    kirby_lives_x = lives_box_x + images.lives_box_width / 2;
    kirby_lives_y = sky_height + (0.39 * stats_bar_height);
  }

  void drawing()
  {
    image(sky_1, sky_1_x, 0, width, height - stats_bar_height);
    image(sky_2, sky_2_x, 0, width, height - stats_bar_height);
  }

  void drawStats()
  {
    image(stats_bar, 0, stats_bar_y, width, stats_bar_height);
    image(health_box, 0, stats_bar_y, images.health_box_width, stats_bar_height); // Breite noch relativ machen
    image(lives_box, lives_box_x, stats_bar_y, images.lives_box_width, stats_bar_height);
    image(enemy_name, 40, energy_ball_health_y, images.health_box_width / 3, stats_bar_height / 6.5);
    image(kirby_name, 40, kirby_health_y, images.health_box_width / 3, stats_bar_height / 6.5);
    images.kirby_multiplier.drawImage(kirby_lives_x - (images.kirby_multiplier.image_width * SCALE *1.5) , kirby_lives_y);
    enemy_health.drawObject();
    kirby_health.drawObject();
    lives.showLives(global.kirby_lives);
  }

  void bewege()
  {
    sky_1_x -= global.SPEED;
    sky_2_x -= global.SPEED;

    if (sky_1_x <= -width)
    {
      sky_1_x = width + sky_2_x;
    }

    if (sky_2_x <= -width)
    {
      sky_2_x = width + sky_1_x;
    }
  }
}
