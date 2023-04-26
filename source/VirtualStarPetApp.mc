/*
  ___ _             __      __    _      _    
 / __| |_ __ _ _ _  \ \    / /_ _| |_ __| |_  
 \__ \  _/ _` | '_|  \ \/\/ / _` |  _/ _| ' \ 
 |___/\__\__,_|_|     \_/\_/\__,_|\__\__|_||_|

       File: VirtualStarPetApp.mc                                       
       Contains: Boiler plate Code                                       
       Created for Garmin Venu 2 Series
       Author : Sarah Bass                                
*/
import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class VirtualStarPetApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new VirtualStarPetView() ] as Array<Views or InputDelegates>;
    }

    // New app settings have been received so trigger a UI update
    function onSettingsChanged() as Void {
        WatchUi.requestUpdate();
    }

}

function getApp() as VirtualStarPetApp {
    return Application.getApp() as VirtualStarPetApp;
}
