class NormalImage implements ImageContainer
{
  PImage image;
  float image_height;
  float image_width;
  
  NormalImage(String path)
  {    
    this.image = loadImage(path);
    this.image_height = image.height;
    this.image_width = image.width;
  }
  
  void drawImage(float x, float y)
  {
    image(image, x, y, image.width * SCALE, image.height * SCALE);
  }
}
