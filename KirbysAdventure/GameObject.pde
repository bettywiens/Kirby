class GameObject
{
  float pixel_x;
  float pixel_y;

  GameTypes type;
  ImageContainer image_container;
  
  GameObject(GameTypes type, float pixel_x, float pixel_y)
  {
    this.type = type;
    this.pixel_x = pixel_x;
    this.pixel_y = pixel_y;
  }
  
  void setImageContainer(ImageContainer container)
  {
    this.image_container = container;
  }
  
  void drawObject()
  {
    image_container.drawImage(pixel_x, pixel_y);
  }
  
  float getPixelX()
  {
    return pixel_x;
  }
  
  float getPixelY()
  {
    return pixel_y;
  }
  
  GameTypes getType()
  {
    return type;
  }
}
