class Menu extends GameObject
{
  boolean enter_pressed = false;

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
  float menu_lives_x = lives_x + 150;
  float menu_lives_y = lives_y;

  float selector_x = 82;
  float selector_y;
  float center = width/2;
  float gap = 50;
  float in_game_menu_x = 300;
  float in_game_menu_pointer_x = in_game_menu_x - 50;
  float game_over_pointer_x = center - images.continue_image.image_width - images.pointer.image_width - 30;
  float game_over_pointer_y = 220;
  float try_again_lives_x;
  float try_again_lives_y = lives_y;

  Menu(float pixel_x, float pixel_y, float size)
  {
    super(GameTypes.MENU, pixel_x, pixel_y, size);

    try_again_x = center - (images.try_again.image_width);
    
    try_again_lives_x = try_again_x + 150;
    no_x = center + images.no.image_width;
    pointer_x  = try_again_x - gap;
    selector_y = 350;
  }

  // Screen, wenn man gewonnen hat:
  void drawWonScreen()
  {
    images.won_background.drawBackgroundImage(0, 0);
    update();
  }

  // Screen, wenn man alle Leben verloren hat (GAME OVER):
  void drawGameOver()
  {
    images.game_over_background.drawBackgroundImage(0, 0);
    images.continue_image.drawImage(center - images.continue_image.image_width, 220);
    images.pointer.drawImage(game_over_pointer_x, game_over_pointer_y);
    update();
  }

  // Menü, bei welchem Spiel gestartet wird (HOME SCREEN):
  void drawHomeMenu()
  {
    images.home_background.drawBackgroundImage(0, 0); // 350 // 390 // 430
    images.selector.drawImage(selector_x, selector_y);
    update();
  }

  // Menü, der im Spiel mit 'e' geöffnet werden kann (IN GAME MENU):
  void drawMenu()
  {
    images.background.drawBackgroundImage(0, 0);
    images.lives.drawImage(lives_x, lives_y);
    Lives menu_lives = new Lives(menu_lives_x, menu_lives_y, global.live_size, images.menu_numbers_path);
    menu_lives.showLives(global.kirby_lives);
    images.game_end.drawImage(in_game_menu_x, game_end_y);
    images.continue_image.drawImage(in_game_menu_x, continue_y);
    images.pointer.drawImage(in_game_menu_pointer_x, pointer_y);
    update();
  }

  // Menü, wenn man ein Leben verloren hat:
  void drawTryAgain()
  {
    global.live_lost = false;
    images.background.drawBackgroundImage(0, 0);
    images.try_again.drawImage(try_again_x, try_again_y);
    images.lives.drawImage(try_again_x, lives_y);
    Lives menu_lives = new Lives(try_again_lives_x, try_again_lives_y, global.live_size, images.menu_numbers_path);
    menu_lives.showLives(global.kirby_lives);
    images.yes.drawImage(try_again_x, yes_no_y);
    images.no.drawImage(no_x, yes_no_y);
    images.pointer.drawImage(pointer_x, yes_no_y);
    update();
  }

  // Wechselt zu den jeweiligen Screens
  void update()
  {
    if (global.menu_open)
    {
      menuOpen();
    } else if (global.try_again_open)
    {
      tryAgainOpen();
    } else if (global.home_open)
    {
      homeOpen();
    } else if (global.game_over)
    {
      gameOverOpen();
    } else if (global.kirby_won)
    {
      kirbyWonOpen();
    }
  }

  void menuOpen()
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
    } else if (enterPressed()) // auswählen
    {
      enter_pressed = false;
      // Spiel beenden
      if (pointer_y == game_end_y)
      {
        global.menu_open = false;
        endGame();
        // Spiel weiterspielen
      } else if (pointer_y == continue_y)
      {
        global.menu_open = false;
      }
    }
  }

  void tryAgainOpen()
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
    } else if (enterPressed())
    {
      enter_pressed = false;
      if (pointer_x == no_x - gap)
      {
        global.try_again_open = false;
        endGame();
        // Nochmal versuchen --> Spiel wird neu gestartet
      } else if (pointer_x == try_again_x - gap)
      {
        tryAgain();
      }
    }
  }

  void homeOpen()
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
    } else if (enterPressed()) // auswählen
    {
      playGame();
    }
  }

  void gameOverOpen()
  {
    // Keine andere Möglichekeit, da man keine Leben mehr hat
    if (enterPressed())
    {
      enter_pressed = false;
      global.game_over = false;
      endGame();
    }
  }

  void kirbyWonOpen()
  {
    if (enterPressed())
    {
      enter_pressed = false;
      global.kirby_won = false;
      endGame();
    }
  }

  boolean enterPressed()
  {
    if (key_handler.enter_pressed)
    {
      enter_pressed = true;
    } else if (!key_handler.enter_pressed && enter_pressed)
    {
      return true;
    }
    return false;
  }

  void endGame()
  {
    resetGame(true);
    global.game_playing = false;
    global.home_open = true;
  }

  void tryAgain()
  {
    resetGame(false);
    global.try_again_open = false;
    global.game_playing = true;
  }

  void playGame()
  {
    resetGame(true);
    global.game_playing = true;
    global.home_open = false;
  }
}
