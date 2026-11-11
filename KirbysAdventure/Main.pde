import java.nio.file.Files;
import java.nio.file.Path;

int SCALE = 2;
float STAR_ANIMATION_SPEED = 0.8;
float ENERGY_BALL_ANIMATION_SPEED = 1;

// Geschwindigkeiten
int SPEED = 4;
int KIRBY_SPEED = 15;
int SHOOTING_STAR_SPEED = 50;
int SHOOTING_ENEMY_SPEED = 20;
int ENERGY_BALL_SPEED = 5;


float kirby_x;
float kirby_y;
float kirby_start_x = 100;
float kirby_start_y = 200;

float kirby_health_x = 200;
float kirby_health_y = 495;

float energy_ball_x;
float energy_ball_y;

float kirby_size;
float energy_ball_size;
float star_size;

float lower_border;

int kirby_lives = 5;

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

NormalImage energy_ball_image;
NormalImage kirby_image;
NormalImage star_image;

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

void setup()
{
  size(800, 600);

  // Images:
  energy_ball_image = new NormalImage("enemy/flying/frame_1.png");
  kirby_image = new NormalImage("kirby/flying.png");
  star_image = new NormalImage("star/kirby/star_1.png");

  key_handler = new KeyHandler();
  sky_background = new Background();

  // Untere Grenze vom Spielfeld
  lower_border = height - sky_background.stats_bar_height;

  // Game Objects:
  game_objects = new ArrayList<GameObject>();

  // Timer:
  timer = new Timer(2); // Timer 10ms
  timer.start();

  // Kirby:
  kirby = new Kirby(kirby_start_x, kirby_start_y, KIRBY_SPEED);
  kirby.size = kirby_image.image_height * 2;
  kirby_size = kirby.size;
  game_objects.add(kirby);
  kirby_x = kirby.pixel_x;
  kirby_y = kirby.pixel_y;
  kirby_health = new KirbyHealth(kirby_health_x, kirby_health_y, 10); //! size wird hier nicht gebraucht vielleicht auf Klassen beschränken wo es gebraucht wird  

  // Energy Ball:
  energy_ball = new EnergyBall (600, 200, ENERGY_BALL_SPEED);
  energy_ball.size = energy_ball_image.image_height * 2;
  game_objects.add(energy_ball);
  enemy_health = new EnemyHealth(200, 537, 300);
  energy_ball_x = energy_ball.pixel_x;
  energy_ball_y = energy_ball.pixel_y;

  // Star:
  star_size = star_image.image_height * 1.5;

  // Leben:
  lives = new Lives(690, kirby_health_y + 23, 20, "health/numbers/");

  // Menü:
  menu = new Menu(0, 0, 0);   
}

void draw()
{
  // IN-GAME MENÜ
  if(kirby_lives == 0)
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
    // HOME SCREEn
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
  
  sky_background.drawing();
  sky_background.bewege();
  sky_background.drawStats();

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
      //fill(255,0,0);
      //rect(projectile.pixel_x, projectile.pixel_y, star_size, star_size);      
    }  
    
  }   

  sky_background.drawStats();
  
  lives.showLives(kirby_lives);
}

void resetGame(boolean resetLives) //
{
  if (resetLives)
  {
    kirby_lives = 1;
  }
  
  // Game Objects:
  game_objects = new ArrayList<GameObject>();
  
  // Kirby:
  kirby = new Kirby(kirby_start_x, kirby_start_y, KIRBY_SPEED);
  kirby.size = kirby_image.image_height * 2;
  kirby_size = kirby.size;
  game_objects.add(kirby);
  kirby_x = kirby.pixel_x;
  kirby_y = kirby.pixel_y;
  kirby_health = new KirbyHealth(kirby_health_x, kirby_health_y, 10); //! size wird hier nicht gebraucht vielleicht auf Klassen beschränken wo es gebraucht wird
  

  // Energy Ball:
  energy_ball = new EnergyBall (600, 200, ENERGY_BALL_SPEED);
  energy_ball.size = energy_ball_image.image_height * 2;
  game_objects.add(energy_ball);
  enemy_health = new EnemyHealth(200, 537, 300);
  energy_ball_x = energy_ball.pixel_x;
  energy_ball_y = energy_ball.pixel_y;
  energy_ball_damaged = false;

  // Star:
  star_size = star_image.image_height * 1.5;
 
 // Leben:
  lives = new Lives(690, kirby_health_y + 23, 20, "health/numbers/");

  menu = new Menu(0, 0, 0);
}

void keyPressed()
{
  key_handler.pressed();
}

void keyReleased()
{
  key_handler.released();
}
