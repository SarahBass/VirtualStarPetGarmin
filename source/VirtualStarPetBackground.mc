/*
  ___ _             __      __    _      _    
 / __| |_ __ _ _ _  \ \    / /_ _| |_ __| |_  
 \__ \  _/ _` | '_|  \ \/\/ / _` |  _/ _| ' \ 
 |___/\__\__,_|_|     \_/\_/\__,_|\__\__|_||_|
       File: VirtualStarPetBackground.mc                                       
       Contains: Boiler Plate Code                                      
       Created for Garmin Venu 2 Series
       Author : Sarah Bass                                
*/
import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class Background extends WatchUi.Drawable {

    function initialize() {
        var dictionary = {
            :identifier => "Background"
        };

        Drawable.initialize(dictionary);
    }

    function draw(dc as Dc) as Void {
        // Set the background color then call to clear the screen
        dc.setColor(Graphics.COLOR_TRANSPARENT, getApp().getProperty("BackgroundColor") as Number);
        dc.clear();
    }

}
