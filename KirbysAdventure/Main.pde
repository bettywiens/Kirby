import java.nio.file.Files;
import java.nio.file.Path;

boolean energy_ball_collided_with_star = false;
boolean kirby_collided_with_star = false;
boolean energy_ball_damaged = false;
boolean live_lost = false;
boolean game_over = false;
boolean menu_open = false;
boolean try_again_open = false;
boolean home_open = true;
boolean game_playing = false;
boolean kirby_won = false;

ArrayList<GameObject> game_objects;
ArrayList<Integer> star_collided_with_kirby;

KeyHandler key_handler;
Background sky_background;
Kirby kirby;
EnergyBall energy_ball;
KirbyStar kirby_star;
Timer timer;
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
  sky_background = new Background();
  images = new Images();
  global = new GlobalVariables();

  // Game Objects:
  game_objects = new ArrayList<GameObject>();
  star_collided_with_kirby = new ArrayList<Integer>();

  // Timer:
  timer = new Timer(2); // Timer 10ms
  timer.start();

  // Kirby:
  kirby = new Kirby(global.kirby_start_x, global.kirby_start_y, global.KIRBY_SPEED);
  game_objects.add(kirby);
  
  kirby_health = new KirbyHealth(global.kirby_health_x, global.kirby_health_y, 10); //! size wird hier nicht gebraucht vielleicht auf Klassen beschränken wo es gebraucht wird

  // Energy Ball:
  energy_ball = new EnergyBall (600, 200, global.ENERGY_BALL_SPEED);
  game_objects.add(energy_ball);
  
  enemy_health = new EnemyHealth(200, 537, 300);

  // Leben:
  lives = new Lives(690, global.kirby_health_y + 23, 20, images.lives_path);

  // Menü:
  menu = new Menu(0, 0, 0);
}

void draw()
{
  // IN-GAME MENÜ
  if (global.kirby_lives == 0)
  {
    game_playing = false;
    game_over = true;
    menu.drawGameOver();
  } else if (menu_open)
  {
    menu.drawMenu();
    // GAME-OVER SCREEN
  } else if (game_over)
  {
    menu.drawGameOver();
    // TRY_AGAIN SCREEN
  } else if (try_again_open)
  {
    menu.drawTryAgain();
    // HOME SCREEN
  } else if (home_open)
  {
    menu.drawHomeMenu();
    // SPIEL AKTIV
  } else if (game_playing)
  {
    firstEnemy();
  } else if (kirby_won)
  {
    menu.drawWonScreen();
  }
}

void firstEnemy()
{

  drawBackground();
  fill(0, 255, 0);
  rect(kirby.pixel_x, kirby.pixel_y, global.kirby_size, global.kirby_size);
  fill(0, 0,255);
  rect(energy_ball.pixel_x, energy_ball.pixel_y, global.energy_ball_size, global.energy_ball_size);

  for (int i = 0; i < game_objects.size(); i++)
  {

    GameObject object = game_objects.get(i);

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
      fill(255, 0, 0);
      rect(projectile.pixel_x, projectile.pixel_y, global.star_size, global.star_size);
    }
  }

  sky_background.drawStats();
}

void resetGame(boolean resetLives) //
{
  if (resetLives)
  {
    global.kirby_lives = 5;
  }

  // Game Objects:
  game_objects = new ArrayList<GameObject>();
  star_collided_with_kirby = new ArrayList<Integer>();

  resetKirby();

  resetEnergyBall();

  // Leben:
  lives = new Lives(690, global.kirby_health_y + 23, 20, images.lives_path);

  menu = new Menu(0, 0, 0);
  
  
}

void resetKirby()
{
  // Kirby:
  kirby = new Kirby(global.kirby_start_x, global.kirby_start_y, global.KIRBY_SPEED);
  game_objects.add(kirby);
  kirby_health = new KirbyHealth(global.kirby_health_x, global.kirby_health_y, 10); //! size wird hier nicht gebraucht vielleicht auf Klassen beschränken wo es gebraucht wird
}

void resetEnergyBall()
{
  // Energy Ball:
  energy_ball = new EnergyBall (global.energy_ball_start_x, global.energy_ball_start_y, global.ENERGY_BALL_SPEED);  
  game_objects.add(energy_ball);
  
  enemy_health = new EnemyHealth(global.energy_ball_health_x, global.energy_ball_health_y, 300); 
  energy_ball_damaged = false;
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
