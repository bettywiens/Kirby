class Menu extends GameObject
{
  boolean enter_pressed = false;

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

  float lives_x = 300;
  float lives_y = 120;
  float game_end_y = lives_y + 75;
  float continue_y = game_end_y + 75;
  float try_again_x;
  float try_again_y = lives_y + 60;
  float yes_no_y = try_again_y + 60;
  float no_x;
  float pointer_x;
  float pointer_y = game_end_y;
  float selector_y;
  float center = width/2;
  float gap = 50;

  Menu(float pixel_x, float pixel_y, float size)
  {
    super(GameTypes.MENU, pixel_x, pixel_y, size);

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

    try_again_x = center - (try_again.image_width);
    no_x = center + no.image_width;
    pointer_x  = try_again_x - gap;
    selector_y = 350;
  }

  void drawWonScreen()
  {
    won_background.drawBackgroundImage(0, 0);
    update();
  }

  void drawGameOver()
  {
    game_over_background.drawBackgroundImage(0, 0);
    continue_image.drawImage(center - continue_image.image_width, 220);
    pointer.drawImage(center-continue_image.image_width-pointer.image_width - 30, 220);
    update();
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

  void update()
  {
    // IN-GAME Menü
    if (menu_open)
    {
      if (key_handler.up_pressed) // pointer nach oben
      {
        if (pointer_y == continue_y)
        {
          pointer_y = game_end_y;
        }
      } else if (key_handler.down_pressed) // pointer nach unten
      {
        if (pointer_y == game_end_y)
        {
          pointer_y = continue_y;
        }
      } else if (key_handler.enter_pressed) // auswählen
      {
        enter_pressed = true;
      } else if (!key_handler.enter_pressed && enter_pressed)
      {
        enter_pressed = false;
        // Spiel beenden
        if (pointer_y == game_end_y)
        {
          resetGame(true);
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
      if (key_handler.left_pressed) // pointer nach links
      {
        if (pointer_x == no_x - gap)
        {
          pointer_x = try_again_x - gap;
        }
      } else if (key_handler.right_pressed) // pointer nach rechts
      {
        if (pointer_x == try_again_x - gap)
        {
          pointer_x = no_x - gap;
        }
      } else if (key_handler.enter_pressed) // auswählen
      {
        enter_pressed = true;
        // Nicht nochmal versuchen --> Spiel beenden, zurück zum Homescreen
      } else if (!key_handler.enter_pressed && enter_pressed)
      {
        enter_pressed = false;
        if (pointer_x == no_x - gap)
        {
          resetGame(true);
          game_playing = false;
          try_again_open = false;
          home_open = true;
          // Nochmal versuchen --> Spiel wird neu gestartet
        } else if (pointer_x == try_again_x - gap)
        {
          resetGame(false);
          try_again_open = false;
          game_playing = true;
        }
      }
      // HOME Screen
    } else if (home_open)
    {
      if (key_handler.down_pressed) // Selector nach unten
      {
        if (selector_y < 430) {
          selector_y += 40;
        }
      } else if (key_handler.up_pressed) // Selector nach oben
      {
        if (selector_y > 350)
        {
          selector_y -= 40;
        }
      } else if (key_handler.e_pressed) // Spiel schließen
      {
        exit();
      } else if (key_handler.enter_pressed) // auswählen
      {
        enter_pressed = true;
      } else if (!key_handler.enter_pressed && enter_pressed)
      {
        enter_pressed = false;
        resetGame(true);
        home_open = false;
        game_playing = true;
      }
      // GAME OVER Screen
    } else if (game_over)
    {
      // Keine andere Möglichekeit, da man keine Leben mehr hat
      if (key_handler.enter_pressed) // auswählen
      {
        enter_pressed = true;
      } else if (!key_handler.enter_pressed && enter_pressed)
      {
        enter_pressed = false;
        resetGame(true);
        game_over = false;
        game_playing = false;
        home_open = true;
      }
    } else if (kirby_won)
    {
      // Keine andere Möglichekeit, da gewonnen
      if (key_handler.enter_pressed) // auswählen
      {
        enter_pressed = true;
      } else if (!key_handler.enter_pressed && enter_pressed)
      {
        enter_pressed = false;
        resetGame(true);
        kirby_won = false;
        game_playing = false;
        home_open = true;
      }
    }
  }
}
