class Background implements Menu
{
  String sky_path = "background/sky.png";

  String stats_bar_path = "background/stats_bar.png";

  PImage sky_1;
  PImage sky_2;
  PImage stats_bar;

  float sky_1_x = 0;
  float sky_2_x = width;

  float stats_bar_height;
  float sky_height;



  Background()
  {
    sky_1 = loadImage(sky_path);
    sky_2 = loadImage(sky_path);
    stats_bar = loadImage(stats_bar_path);

    stats_bar_height = sky_1.height / 8.5 ;
    sky_height = height - stats_bar_height;
  }

  void drawing()
  {
    image(sky_1, sky_1_x, 0, width, sky_height);
    image(sky_2, sky_2_x, 0, width, sky_height);
    image(stats_bar, 0, height - stats_bar_height, width, stats_bar_height);
  }
  
  void bewege()
  {
    sky_1_x -= SPEED;
    sky_2_x -= SPEED;
    
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
