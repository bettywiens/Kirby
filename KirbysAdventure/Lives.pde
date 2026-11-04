class Lives extends GameObject 
{
  NormalImage zero;
  NormalImage live_image_0;
  NormalImage live_image_1;
  
  String image_path;
  String livesS;

  Lives(float pixel_x, float pixel_y, float size) 
  {
    super(GameTypes.LIVES, pixel_x, pixel_y, size);
    zero = new NormalImage("health/numbers/0.png");
    image_path = "health/numbers/";
    setImageContainer(zero);
  }


  void showLives(int lives) 
  {
    // Punktzahl in char-Array umwandeln
    livesS = String.valueOf(lives);
    char[] livesArray = livesS.toCharArray();
    
    // Punkte werden an passender Stelle auf Spielfeld angezeigt
    if (lives < 10) 
    {
      live_image_0 = new NormalImage(image_path + lives + ".png");
      live_image_1 = zero;
      
    } else if (lives >= 10) 
    {
      live_image_0 = new NormalImage(image_path + livesArray[1] + ".png");
      live_image_1 = new NormalImage(image_path + livesArray[0] + ".png");      
    } 
    live_image_0.drawImage(690, kirby_health_y + 23);
    live_image_1.drawImage(670, kirby_health_y + 23);
  }
}
