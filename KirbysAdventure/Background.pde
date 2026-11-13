 class Background
{ 
  PImage sky_1;
  PImage sky_2;
  PImage stats_bar;

  float sky_1_x = 0;
  float sky_2_x = width;

  float stats_bar_height;
  float sky_height;



  Background()
  {
    sky_1 = loadImage(images.sky_path);
    sky_2 = loadImage(images.sky_path);
    stats_bar = loadImage(images.stats_bar_path);

    stats_bar_height = sky_1.height / 8.5 ;
    sky_height = height - stats_bar_height;
  }

  void drawing()
  {
    image(sky_1, sky_1_x, 0, width, sky_height);
    image(sky_2, sky_2_x, 0, width, sky_height);
  }
  
  void drawStats()
  {
    image(stats_bar, 0, sky_height, width, stats_bar_height);
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
