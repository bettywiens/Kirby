import java.nio.file.Files;
import java.nio.file.Path;

KeyHandler key_handler;
Background sky_background;
Kirby kirby;
EnergyBall energy_ball;
KirbyStar kirby_star;
EnemyHealth enemy_health;
KirbyHealth kirby_health;
Lives lives;
Menu menu;
Images images;
GlobalVariables global;

void setup()
{
  size(800, 600);

  key_handler = new KeyHandler();
  images = new Images();
  sky_background = new Background();
  global = new GlobalVariables();  

  // Menü:
  menu = new Menu(0, 0, 0);
  
  // Kirby:
  kirby = new Kirby(global.kirby_start_x, global.kirby_start_y, global.KIRBY_SPEED);
  global.game_objects.add(kirby);
  kirby_health = new KirbyHealth(global.kirby_health_x, global.kirby_health_y, 10); //! size wird hier nicht gebraucht vielleicht auf Klassen beschränken wo es gebraucht wird
  // --- Kirby Leben:
  lives = new Lives(global.kirby_lives_x, global.kirby_lives_y, 20, images.lives_path);

  // Energy Ball:
  energy_ball = new EnergyBall (600, 200, global.ENERGY_BALL_SPEED);
  global.game_objects.add(energy_ball);
  enemy_health = new EnemyHealth(global.energy_ball_health_x, global.energy_ball_health_y, 300);
}

void draw()
{
  // IN-GAME MENÜ
  if (global.kirby_lives == 0)
  {
    global.game_playing = false;
    global.game_over = true;
    menu.drawGameOver();
  } else if (global.menu_open)
  {
    menu.drawMenu();
    // GAME-OVER SCREEN
  } else if (global.game_over)
  {
    menu.drawGameOver();
    // TRY_AGAIN SCREEN
  } else if (global.try_again_open)
  {
    menu.drawTryAgain();
    // HOME SCREEN
  } else if (global.home_open)
  {
    menu.drawHomeMenu();
    // SPIEL AKTIV
  } else if (global.game_playing)
  {
    firstEnemy();
    // SPIEL GEWONNEN
  } else if (global.kirby_won)
  {
    menu.drawWonScreen();
  }
}

void firstEnemy()
{

  drawBackground();
  
  // Hitboxen Kirby und EnergyBall:
  //fill(0, 255, 0);
  //rect(kirby.pixel_x, kirby.pixel_y, global.kirby_size, global.kirby_size);
  //fill(0, 0,255);
  //rect(energy_ball.pixel_x, energy_ball.pixel_y, global.energy_ball_size, global.energy_ball_size);

  for (int i = 0; i < global.game_objects.size(); i++)
  {

    GameObject object = global.game_objects.get(i);

    if (object instanceof Character)
    {
      Character character = (Character) object;
      character.update();
      character.drawObject();
      character.move();
    }

    if (object instanceof Star)
    {
      Star projectile = (Star) object;
      projectile.shoot();
      projectile.drawObject();
      // Hitboxen von Projektilen:
      //fill(255, 0, 0);
      //rect(projectile.pixel_x, projectile.pixel_y, global.star_size, global.star_size);
    }
  }

  sky_background.drawStats();
}

void resetGame(boolean resetLives) //
{
  if (resetLives)
  {
    global.resetLives();
  }
  
  global.init();

  resetKirby();

  resetEnergyBall();

  // Leben:
  lives = new Lives(global.kirby_lives_x, global.kirby_lives_y, 20, images.lives_path);

  menu = new Menu(0, 0, 0);
  
  
}

void resetKirby()
{
  // Kirby:
  kirby = new Kirby(global.kirby_start_x, global.kirby_start_y, global.KIRBY_SPEED);
  global.game_objects.add(kirby);
  kirby_health = new KirbyHealth(global.kirby_health_x, global.kirby_health_y, 10); //! size wird hier nicht gebraucht vielleicht auf Klassen beschränken wo es gebraucht wird
}

void resetEnergyBall()
{
  // Energy Ball:
  energy_ball = new EnergyBall (global.energy_ball_start_x, global.energy_ball_start_y, global.ENERGY_BALL_SPEED);  
  global.game_objects.add(energy_ball);
  
  enemy_health = new EnemyHealth(global.energy_ball_health_x, global.energy_ball_health_y, 300); 
  global.energy_ball_damaged = false;
}

void drawBackground()
{
  sky_background.drawing();
  sky_background.bewege();
}

void keyPressed()
{
  key_handler.pressed();
}

void keyReleased()
{
  key_handler.released();
}
