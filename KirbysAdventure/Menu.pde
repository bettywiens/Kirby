class Menu extends GameObject
{
  NormalImage game_over_screen;  
  NormalImage background;
  NormalImage game_end;
  NormalImage lives;
  NormalImage continue_image;
  NormalImage pointer;
  
  float lives_x = 300;
  float lives_y = 160;
  float continue_y = 310;
  float game_end_y = 235;
  float pointer_y = 235;
  
  Menu(float pixel_x, float pixel_y, float size)
  {
    super(GameTypes.MENU, pixel_x, pixel_y, size);
    game_over_screen = new NormalImage("menu/game_over_screen.png");    
    game_end = new NormalImage("menu/game_end.png");
    lives = new NormalImage("menu/lives.png");
    continue_image = new NormalImage("menu/continue.png");
    pointer = new NormalImage("menu/pointer.png");
    background = new NormalImage("menu/background.png");
    
    //menu_lives = new Lives(500,250,20,"menu/numbers/");
  }
  
  void drawGameOver()
  {
    game_over_screen.drawBackgroundImage(0,0);
  }
  
  void drawMenu()
  {    
    background.drawBackgroundImage(0,0);
    lives.drawImage(lives_x, lives_y);
    Lives menu_lives = new Lives(lives_x + 150, lives_y, 20, "menu/numbers/");    
    menu_lives.showLives(kirby_lives);
    //lives.showLives(kirby_lives);
    game_end.drawImage(300,game_end_y);
    continue_image.drawImage(300,continue_y);
    pointer.drawImage(250,pointer_y);
    // Lives hinzufügen
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
      if (pointer_y == game_end_y)
      {
        // TO DO:
        // Spiel beenden, zuück zum Startbildschirm
        // Leben zurücksetzen
        // Startbildschirm implementieren
        println("end game");
      } else if (pointer_y == continue_y)
      {
        // TO DO:
        // Spiel weiter fortführen
        // Leben beibehalten, Level Fortschritt sollte weitergehen wo es aufgehört hat
        println("continue game");
      }
    }
  }
}
