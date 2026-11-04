class Menu extends GameObject
{
  NormalImage game_over_screen;
  String background_path = "menu/background.png";
  PImage background;
  NormalImage game_end;
  NormalImage lives;
  NormalImage continue_image;
  NormalImage pointer;
  
  float continue_y = 275;
  float game_end_y = 200;
  float pointer_y = 200;
  
  Menu(float pixel_x, float pixel_y, float size)
  {
    super(GameTypes.MENU, pixel_x, pixel_y, size);
    game_over_screen = new NormalImage("menu/game_over_screen.png");    
    game_end = new NormalImage("menu/game_end.png");
    lives = new NormalImage("menu/lives.png");
    continue_image = new NormalImage("menu/continue.png");
    pointer = new NormalImage("menu/pointer.png");
  }
  
  void drawGameOver()
  {
    game_over_screen.drawImage(0,0);
  }
  
  void drawMenu()
  {
    background = loadImage(background_path);
    image(background, 0, 0, width, height);
    game_end.drawImage(300,game_end_y);
    continue_image.drawImage(300,continue_y);
    pointer.drawImage(250,pointer_y);
    update();
  }
  
  void update()
  {
    if (key_handler.up_pressed)
    {
      if (pointer_y == continue_y)
      {
        pointer_y = game_end_y;
      }
    } else if (key_handler.down_pressed)
    {
      if (pointer_y == game_end_y)
      {
        pointer_y = continue_y;
      }
    } else if (key_handler.enter_pressed)
    {
      if ()
    }
  }
}
