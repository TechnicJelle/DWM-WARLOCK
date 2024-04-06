//Necessary for getScreenMouse() to work:
import java.awt.Point;
import java.awt.MouseInfo;

class WindowDragger {
  private PApplet pApplet;
  private PVector winPos;
  private PVector grabPoint = null;

  private int startPosX, startPosY;

  //Set the start position of the window here (in screen pixels)
  public WindowDragger(int x, int y) {
    this.pApplet = null;
    this.winPos = new PVector(x, y);
    startPosX = x;
    startPosY = y;
  }

  //Pass in `this` in case you have a specific PApplet you want this WindowDragger to bind to.
  //Set the start position of the window here (in screen pixels)
  public WindowDragger(PApplet pApplet, int x, int y) {
    this.pApplet = pApplet;
    this.winPos = new PVector(x, y);
  }

  //Queue window for moving along with the cursor.
  public void clickDragWindow() {
    if (pApplet == null ? mousePressed : pApplet.mousePressed) {
      PVector sm = getScreenMouse();
      if (grabPoint == null) {
        //Only set the grab point the first moment we click the window.
        grabPoint = PVector.sub(sm, winPos);
      }
      sm.sub(grabPoint); //If we have a grab point, offset the window to that point
      winPos.set(sm);
    } else {
      grabPoint = null; //We don't have a grab point when we're not clicking the window
    }
  }

  //Call at end of frame.
  private void applyWindowPos() {
    if (pApplet == null) {
      surface.setLocation(int(winPos.x), int(winPos.y));
    } else {
      pApplet.getSurface().setLocation(int(winPos.x), int(winPos.y));
    }
  }

  public void setWindowPos(int x, int y) {
    winPos.set(x, y);
  }

  //Queue window for centering.
  public void centerWindow() {
    winPos.set(startPosX, startPosY);
  }

  public PVector getWinPos() {
    return winPos.copy();
  }
  public PVector getScreenMouse() {
    Point p = MouseInfo.getPointerInfo().getLocation();
    return new PVector(p.x, p.y);
  }
}
