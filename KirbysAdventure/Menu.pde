class Menu extends GameObject
{
  NormalImage game_over_screen;
  NormalImage background;
  NormalImage game_end;
  NormalImage lives;
  NormalImage continue_image;
  NormalImage pointer;
  NormalImage try_again;
  NormalImage yes;
  NormalImage no;
  NormalImage home_background;
  NormalImage selector;

  float lives_x = 300;
  float lives_y = 160;
  float continue_y = 310;
  float game_end_y = 235;
  float pointer_y = 235;
  float gap = 50;
  float try_again_y = lives_y + 60;
  float try_again_x;
  float yes_no_y = try_again_y + 60;
  float no_x;
  float center = width/2;
  float pointer_x;
  float selector_y;

  Menu(float pixel_x, float pixel_y, float size)
  {
    super(GameTypes.MENU, pixel_x, pixel_y, size);
    game_over_screen = new NormalImage("menu/game_over_screen.png");
    game_end = new NormalImage("menu/game_end.png");
    lives = new NormalImage("menu/lives.png");
    continue_image = new NormalImage("menu/continue.png");
    pointer = new NormalImage("menu/pointer.png");
    background = new NormalImage("menu/background.png");
    try_again = new NormalImage("menu/try_again.png");
    yes = new NormalImage("menu/yes.png");
    no = new NormalImage("menu/no.png");
    home_background = new NormalImage("menu/home/background.png");
    selector = new NormalImage("menu/home/selector.png");

    try_again_x = center - (try_again.image_width);
    no_x = center + no.image_width;
    pointer_x  = try_again_x - gap;
    selector_y = 350;
  }

  void drawGameOver()
  {
    game_over_screen.drawBackgroundImage(0, 0);
  }

  void drawHomeMenu()
  {
    home_background.drawBackgroundImage(0, 0); // 350 // 390 // 430
    selector.drawImage(82, selector_y);
    update();
  }

  void drawMenu()
  {
    background.drawBackgroundImage(0, 0);
    lives.drawImage(lives_x, lives_y);
    Lives menu_lives = new Lives(lives_x + 150, lives_y, 20, "menu/numbers/");
    menu_lives.showLives(kirby_lives);
    game_end.drawImage(300, game_end_y);
    continue_image.drawImage(300, continue_y);
    pointer.drawImage(250, pointer_y);
    update();
  }

  void drawTryAgain()
  {
    live_lost = false;
    background.drawBackgroundImage(0, 0);
    try_again.drawImage(try_again_x, try_again_y);
    lives.drawImage(try_again_x, lives_y);
    Lives menu_lives = new Lives(try_again_x + 150, lives_y, 20, "menu/numbers/");
    menu_lives.showLives(kirby_lives);
    yes.drawImage(try_again_x, yes_no_y);
    no.drawImage(no_x, yes_no_y);
    pointer.drawImage(pointer_x, yes_no_y);
    update();
  }

  void update() // add to determine if we're in try_again or menu
  {
    // IN-GAME Menü
    if (menu_open)
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
        // Spiel beenden
        if (pointer_y == game_end_y)
        {
          game_playing = false;
          menu_open = false;
          home_open = true;
        // Spiel weiterspielen
        } else if (pointer_y == continue_y)
        {
          menu_open = false;                    
        }
      }
    // TRY-AGAIN Menü
    } else if (try_again_open)
    {
      if (key_handler.left_pressed)
      {
        if (pointer_x == no_x - gap)
        {
          pointer_x = try_again_x - gap;
        }
      } else if (key_handler.right_pressed)
      {
        if (pointer_x == try_again_x - gap)
        {
          pointer_x = no_x - gap;
        }
      } else if (key_handler.enter_pressed)
      {
        // Nicht nochmal versuchen
        if (pointer_x == no_x - gap)
        {
          println("nein");
          game_playing = false;          
          try_again_open = false;
          home_open = true;          
        // Nochmal versuchen
        } else if (pointer_x == try_again_x - gap)
        {
          try_again_open = false;
          resetGame();
          game_playing = true;
        }
      }
    // HOME Screen
    } else if (home_open)
    {
      if (key_handler.down_pressed)
      {
        if (selector_y < 430) {
          selector_y += 40;
        }
      } else if (key_handler.up_pressed)
      {
        if (selector_y > 350)
        {
          selector_y -= 40;
        }
      } else if (key_handler.e_pressed)
      {
        exit();
      }
      else if (key_handler.enter_pressed)
      {
        home_open = false;
        resetGame();
        game_playing = true;
      }
    }
  }
}
