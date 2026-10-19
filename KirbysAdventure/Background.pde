class Background implements Menu
{
  String sky_path = "background/sky.png";
  String stats_bar_path = "background/stats_bar.png";

  PImage sky;
  PImage stats_bar;

  float stats_bar_height;
  float sky_height;



  Background()
  {
    sky = loadImage(sky_path);
    stats_bar = loadImage(stats_bar_path);

    stats_bar_height = sky.height / 8;
    sky_height = height - stats_bar_height;
  }

  void drawing(float x, float y)
  {
    image(sky, x, y, width, sky_height);
    image(stats_bar, 0, height - stats_bar_height, width, stats_bar_height);
  }
}
