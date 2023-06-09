/*                                             *
   _____ __        *       _       __      __       __  
  / ___// /_____ ______   | |     / /___ _/ /______/ /_  *
  \__ \/ __/ __ `/ ___/   | | /| / / __ `/ __/ ___/ __ \
 ___/ / /_/ /_/ / /   *   | |/ |/ / /_/ / /_/ /__/ / / / *
/____/\__/\__,_/_/        |__/|__/\__,_/\__/\___/_/ /_/ 
                                                                                                                                                                 
  /\   File: VirtualStarPetView.mc              *                         
  \/   Contains: Most Important Code     /\
       Created for Garmin Venu 2 Series  \/           *
       Author : Sarah Bass                        

*/

/*-------------------------------------------------------------
  _                     _      
 (_)_ __  _ __  ___ _ _| |_ ___
 | | '  \| '_ \/ _ \ '_|  _(_-<
 |_|_|_|_| .__/\___/_|  \__/__/
         |_|                   
----------------------------------------------------------------*/
import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;
import Toybox.Activity;
import Toybox.Math;
import Toybox.Application.Storage;
import Toybox.Weather;
import Toybox.Time;
import Toybox.Position;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.System; 
using Toybox.UserProfile;
using Toybox.ActivityMonitor;
using Toybox.SensorHistory;
using Toybox.Position;

//--------------------------------------------------//
/*            
  Program Outline:
   Class{ 
      Initialize Global Variables
      Initialize Bitmaps : function initialize()
      Initialize Layout : function onLayout()
      Update Scene : function onUpdate()
      Additional Functions :
         Chinese Horoscope
         Moon phase
         Heart Rate
         Zodiac Sign
         Void Garmin Functions 
    }    
*/
//---------------------------------------------------//

class VirtualStarPetView extends WatchUi.WatchFace {

/*
               _      _    _        
 __ ____ _ _ _(_)__ _| |__| |___ ___
 \ V / _` | '_| / _` | '_ \ / -_|_-<
  \_/\__,_|_| |_\__,_|_.__/_\___/__/
                                    
*/
   
    //Need Activity and Activity Monitor for steps, calories, heart
    var sensorIter = getIterator();
    //Variables for placement of Bitmaps
    var venus2X = LAYOUT_HALIGN_RIGHT;
    var venus2Y = LAYOUT_VALIGN_CENTER;
    var venus2XL = 20;
    var venus2XM = 35;
    var venumovey =  116;
    var venus2YR = 248;
    var venus2YS = 78;  
    //Variable names for Bitmaps
      var star;
      var specialstar;
      var baby;
      var babyboy;
      var egg;
      var goal1;
      var goal2;
      var goal3;
      var goal4;
      var eyes;
      var eyes2;
      var mouth1;
      var mouth2;
      var mouth3;
      var mouth4;
      var moon1;
      var risepic;
      var setpic;
    
    
/*
  _      _ _   _      _ _        
 (_)_ _ (_) |_(_)__ _| (_)______ 
 | | ' \| |  _| / _` | | |_ / -_)
 |_|_||_|_|\__|_\__,_|_|_/__\___|
                                 
*/
    function initialize() {
    

        WatchFace.initialize();
        View.initialize();

        
//Variables needed to initialize the correct Bitmaps        
var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
var fulldateString = Lang.format(
    "$1$ $2$",
    [
        today.month,
        today.day,
    ] 
);

var dayString = Lang.format(
    "$1$",
[
today.day_of_week
]);
/*
  _    _ _                   
 | |__(_) |_ _ __  __ _ _ __ 
 | '_ \ |  _| '  \/ _` | '_ \
 |_.__/_|\__|_|_|_\__,_| .__/
                       |_|   

*/


        eyes = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.eyes,
            :locX=> venus2X,
            :locY=> venus2Y
        });
        mouth1 = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.mouth1,
             :locX=> venus2X,
            :locY=> venus2Y
        });
 eyes2 = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.eyes1,
            :locX=> venus2X,
            :locY=> venus2Y
        });
        mouth2 = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.mouth2,
             :locX=> venus2X,
            :locY=> venus2Y
        });
         mouth3 = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.mouth3,
             :locX=> venus2X,
            :locY=> venus2Y
        });
         mouth4 = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.mouth4,
             :locX=> venus2X,
            :locY=> venus2Y
        });
         star = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.star,
             :locX=> venus2X,
            :locY=> venus2Y
        });

        baby= new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.baby,
             :locX=> venus2X,
            :locY=> venus2Y
        });
          babyboy= new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.babyboy,
             :locX=> venus2X,
            :locY=> venus2Y
        });
            egg = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.egg,
             :locX=> venus2X,
            :locY=> venus2Y
        });
            risepic = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.sunrise,
             :locX=> venus2XM,
            :locY=> venus2YS
        });
            setpic = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.sunset,
             :locX=> venus2XM,
            :locY=> venus2YR
        });

  // 0 => New Moon
  // 1 => Waxing Crescent Moon
  // 2 => Quarter Moon
  // 3 => Waxing Gibbous Moon
  // 4 => Full Moon
  // 5 => Waning Gibbous Moon
  // 6 => Last Quarter Moon
  // 7 => Waning Crescent Moon
  var moonnumber = getMoonPhase(2023, 3, 25);
  // var moonnumber = getMoonPhase(today.year, today.month, today.day);

  
  //Moon Bitmpas
  switch (moonnumber){
           case 0:  
            moon1 = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.newmoon,
            :locX=> venus2XL,
            :locY=> venus2Y
        });
        break;
            case 1:  
            moon1 = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.waxcres,
            :locX=> venus2XL,
            :locY=> venus2Y
        }); 
           case 2:  
            moon1 = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.firstquar,
            :locX=> venus2XL,
            :locY=> venus2Y
        });
        break;
           case 3:  
            moon1 = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.waxgib,
            :locX=> venus2XL,
            :locY=> venus2Y
        });
        break;
            case 4:  
            moon1 = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.full,
            :locX=> venus2XL,
            :locY=> venus2Y
        });
        break;
           case 5:  
            moon1 = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.wangib,
            :locX=> venus2XL,
            :locY=> venus2Y
        });
        break;
           case 6:  
            moon1 = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.thirdquar,
            :locX=> venus2XL,
            :locY=> venus2Y
        });
        break;
           case 7:  
            moon1 = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.wancres,
            :locX=> venus2XL,
            :locY=> venus2Y
        });
        break;
        default:  
            moon1 = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.full,
            :locX=> venus2XL,
            :locY=> venus2Y
        });}


        //Star Pet Bitmaps
        switch(fulldateString){
           case "Dec 25":  
            specialstar = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.stardecember,
            :locX=> venus2X,
            :locY=> venus2Y
        });
            break;
            case "Dec 1":  
            specialstar = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.stardecember,
            :locX=> venus2X,
            :locY=> venus2Y
        });
             break;
            case "Dec 24":  
            specialstar = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.stardecember,
            :locX=> venus2X,
            :locY=> venus2Y
        });
            break;
            case "Apr 9":  
            specialstar = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.stareaster,
            :locX=> venus2X,
            :locY=> venus2Y
        });
             break;
             case "Mar 31":  
            specialstar = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.stareaster,
            :locX=> venus2X,
            :locY=> venus2Y
        });
             break;
            case "Apr 20":  
            specialstar = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.stareaster,
            :locX=> venus2X,
            :locY=> venus2Y
        });
             break;
             case "Apr 5":  
            specialstar = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.stareaster,
            :locX=> venus2X,
            :locY=> venus2Y
        });
             break;     
             case "Jul 4":  
            specialstar = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.starjuly4,
            :locX=> venus2X,
            :locY=> venus2Y
        });
             break;
             case "Nov 11":  
            specialstar = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.starjuly4,
            :locX=> venus2X,
            :locY=> venus2Y
        });
             break;
            case "May 29":  
            specialstar = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.starjuly4,
            :locX=> venus2X,
            :locY=> venus2Y
        });
             break;
            case "Jun 19":  
            specialstar = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.starjuneteenth,
            :locX=> venus2X,
            :locY=> venus2Y
        });
             break;
            case "Jan 15":  
            specialstar = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.starjuneteenth,
            :locX=> venus2X,
            :locY=> venus2Y
        });
             break;
             case "Mar 17":  
            specialstar = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.starmarch,
            :locX=> venus2X,
            :locY=> venus2Y
        });
             break;       
                                 case "Nov 25":  
            specialstar = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.starnovember,
            :locX=> venus2X,
            :locY=> venus2Y
        });
             break; 
                                   case "Nov 24":  
            specialstar = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.starnovember,
            :locX=> venus2X,
            :locY=> venus2Y
        });
             break;    
                                    case "Nov 4":  
            specialstar = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.starnovember,
            :locX=> venus2X,
            :locY=> venus2Y
        });
             break;   
                                     case "Oct 1":  
            specialstar = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.staroctober,
            :locX=> venus2X,
            :locY=> venus2Y
        });
             break; 
                                     case "Oct 13":  
            specialstar = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.staroctober,
            :locX=> venus2X,
            :locY=> venus2Y
        });
             break;   
                                         case "Oct 31":  
            specialstar = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.staroctober,
            :locX=> venus2X,
            :locY=> venus2Y
        });
             break; 
         default:                                       
 switch (dayString){
        case "Mon":
            specialstar = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.star7,
            :locX=> venus2X,
            :locY=> venus2Y
        });
             break;
       case "Tue":
            specialstar = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.star1,
            :locX=> venus2X,
            :locY=> venus2Y
        });
             break;      
      case "Wed":
            specialstar = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.star2,
            :locX=> venus2X,
            :locY=> venus2Y
        });
             break;
      case "Thu":
            specialstar = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.star3,
            :locX=> venus2X,
            :locY=> venus2Y
        });
             break;
      case "Fri":
            specialstar = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.star4,
            :locX=> venus2X,
            :locY=> venus2Y
        });
             break;
       case "Sat":
            specialstar = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.star5,
            :locX=> venus2X,
            :locY=> venus2Y
        });
             break;      
      case "Sun":
            specialstar = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.star6,
            :locX=> venus2X,
            :locY=> venus2Y
        });
             break;
       default:    
       specialstar = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.star4,
            :locX=> venus2X,
            :locY=> venus2Y
        });
      }
        }

    }
/*
  _                    _   
 | |__ _ _  _ ___ _  _| |_ 
 | / _` | || / _ \ || |  _|
 |_\__,_|\_, \___/\_,_|\__|
         |__/              
*/
    // Load your string resources here from Layout
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc)); }


/*
                _      _             _            
  _  _ _ __  __| |__ _| |_ ___  __ _(_)_____ __ __
 | || | '_ \/ _` / _` |  _/ -_) \ V / / -_) V  V /
  \_,_| .__/\__,_\__,_|\__\___|  \_/|_\___|\_/\_/ 
      |_|                                         

   All Strings and Images are Drawn and Called here
*/    
    function onUpdate(dc as Dc) as Void {


/*
               _      _    _        
 __ ____ _ _ _(_)__ _| |__| |___ ___
 \ V / _` | '_| / _` | '_ \ / -_|_-<
  \_/\__,_|_| |_\__,_|_.__/_\___/__/
                                    
*/
        // Variables for Data-------------------------------------------
       var goal = 5000; 
       var profile = UserProfile.getProfile();
        var timeFormat = "$1$:$2$";
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;
        var minutes = clockTime.min;
        var seconds = clockTime.sec;
        if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else {
            if (getApp().getProperty("UseMilitaryFormat")) {
                timeFormat = "$1$$2$";
                hours = hours.format("%02d");
            }
        }
    var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);
    var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
    var dateString = Lang.format(
    "$1$ , $2$ $3$ $4$",
    [
        today.day_of_week,
        today.month,
        today.day,
        today.year
    ] 
    );
    var mySettings = System.getDeviceSettings();
    var myStats = System.getSystemStats();
    var genderEntry = profile.gender;
    var birthEntry =profile.birthYear;
    var phonestatus = mySettings.phoneConnected;
    var info = ActivityMonitor.getInfo();
    var batterycharging =  myStats.charging;
    var battery = Lang.format("$1$",[((myStats.battery)).format("%2d")]);
    var batterylife = Lang.format("$1$",[(myStats.batteryInDays).format("%2d")]);
    var steps = (info.steps);
    var calories = info.calories;
    var heart = "";
    if (seconds%2 == 0){if (sensorIter != null) {
     heart =(sensorIter.next().data);
    }else { heart = "";}}else {heart = "";}
 	
    var timeStamp= new Time.Moment(Time.today().value());
         
	var positions = Activity.Info.currentLocation;
        if (positions == null){
        positions=new Position.Location( 
    {
        :latitude => 33.684566,
        :longitude => -117.826508,
        :format => :degrees
    }
    );
    }
    var sunrise = Time.Gregorian.info(Toybox.Weather.getSunrise(positions, timeStamp), Time.FORMAT_MEDIUM);
        
	var sunriseHour = sunrise.hour;
         if (!System.getDeviceSettings().is24Hour) {
            if (sunrise.hour > 12) {
                sunriseHour = (hours - 12).abs();
            }
        } else {
            if (getApp().getProperty("UseMilitaryFormat")) {
                timeFormat = "$1$$2$";
                sunriseHour = sunrise.hour.format("%02d");
            }
        }
        

    var sunset = Time.Gregorian.info(Toybox.Weather.getSunset(positions, timeStamp), Time.FORMAT_MEDIUM);
        
	var sunsetHour = sunset.hour;
         if (!System.getDeviceSettings().is24Hour) {
            if (sunset.hour > 12) {
                sunsetHour = (hours - 12).abs();
            }
        } else {
            if (getApp().getProperty("UseMilitaryFormat")) {
                timeFormat = "$1$$2$";
                sunsetHour = sunset.hour.format("%02d");
            }
        }

    var AMPM = "";       
    if (!System.getDeviceSettings().is24Hour) {
        if (clockTime.hour > 12) {
                AMPM = "PM";
            }else{
                AMPM = "AM";
            }}

    var phoneI="";
    var chargeI = "";
    if (phonestatus == true){phoneI = "Y";}
    else{phoneI = "N";}
    if (batterycharging == true){chargeI = "Y";}
    else{chargeI = "N";}
    var TempMetric = System.getDeviceSettings().temperatureUnits;

    var TEMP = Toybox.Weather.getCurrentConditions().feelsLikeTemperature;
    var FC = "C";
    var cond = Toybox.Weather.getCurrentConditions().condition;

    if (TempMetric == System.UNIT_METRIC){
    TEMP = Toybox.Weather.getCurrentConditions().feelsLikeTemperature;
    FC = "C";
    }else{
    TEMP = ((((((Toybox.Weather.getCurrentConditions().feelsLikeTemperature).toDouble())*9)/5)+32).toNumber()); 
    FC = "F";   
    }


    var monthString = Lang.format(
    "$1$",
    [
    today.month
    ]);

    var horoscopeYear = getChineseYear(today.year);
    var horoscopeBirth =getChineseYear(birthEntry);
    var monthZodiac = getHoroscope(4, 25);





//----------PRINT TO SYSTEM CHECKS ------------------------------------
//System.println(AMPM);
//System.println(sunsetHour + ":" + sunset.min.format("%02u")+"PM");
//System.println(sunriseHour + ":" + sunrise.min.format("%02u")+"AM");
//System.println("You have taken: " + steps +
//               " steps and burned: " + calories + " calories!");
//System.println(myStats.totalMemory);
//System.println(myStats.usedMemory);
//System.println(myStats.freeMemory);
//----------PRINT TO SYSTEM CHECKS ------------------------------------        
        
        
    // Variables of text From Layout-------------------------------------------
        var timeText = View.findDrawableById("TimeLabel") as Text;
        var dateText = View.findDrawableById("DateLabel") as Text;
        var batteryText = View.findDrawableById("batteryLabel") as Text;
        var heartText = View.findDrawableById("heartLabel") as Text;
        var stepText = View.findDrawableById("stepsLabel") as Text;
        var calorieText = View.findDrawableById("caloriesLabel") as Text;
        var horoscopeText = View.findDrawableById("horoscopeLabel") as Text;
        var sunriseText = View.findDrawableById("sunriseLabel") as Text;
        var sunsetText = View.findDrawableById("sunsetLabel") as Text;
        var temperatureText = View.findDrawableById("tempLabel") as Text;
        var connectText = View.findDrawableById("connectLabel") as Text;
        
    // Variables for Data END-------------------------------------------
/*
          _     _           _   
  ___ ___| |_  | |_ _____ _| |_ 
 (_-</ -_)  _| |  _/ -_) \ /  _|
 /__/\___|\__|  \__\___/_\_\\__|
                                
Set Text Values from Data Variables 

*/
//---------------------------TEXT---------------------------------------------
        sunriseText.setText(sunriseHour + ":" + sunrise.min.format("%02u")+"AM");
        sunsetText.setText(sunsetHour + ":" + sunset.min.format("%02u")+"PM");
        temperatureText.setText("  "+cond +" "+ TEMP + "°" + FC);
        timeText.setText(timeString+" "+AMPM);
        dateText.setText(dateString);
                if (myStats.charging == true){batteryText.setText("CHARGE");}
        else{
            if (minutes%2 == 0){ batteryText.setText(" "+battery + "%");}
            else{batteryText.setText("DAYS:"+ batterylife) ;} } 
        heartText.setText("-"+heart+"-");
        stepText.setText(""+steps);
        calorieText.setText(""+calories);
        horoscopeText.setText(genderEntry + " "+ horoscopeYear + " "+ horoscopeBirth + " " + monthZodiac);
        connectText.setText(phoneI+" "+chargeI);
       //---------------------------TEXT--------------------------------------------- 
      
        View.onUpdate(dc);
        
/*
     _                   _    _ _                      
  __| |_ _ __ ___ __ __ | |__(_) |_ _ __  __ _ _ __ ___
 / _` | '_/ _` \ V  V / | '_ \ |  _| '  \/ _` | '_ (_-<
 \__,_|_| \__,_|\_/\_/  |_.__/_|\__|_|_|_\__,_| .__/__/
                                              |_|      
  Star Pet has different forms that Change based on Data                                            
  Star Moves up and Down and Changes Face every second
*/ 


         var fakesteps = info.steps; 
         //Fake Stes can be replaced with your own values to test
        if (fakesteps < goal/4){ egg.draw(dc);  }
        else if (fakesteps > (goal/4) && fakesteps < ((goal*2)/4)){ baby.draw(dc);  goal1.draw(dc);}
        else if (fakesteps > ((goal*2)/4) && fakesteps < ((goal*3)/4)){ star.draw(dc);  goal2.draw(dc);}
        else if (fakesteps > ((goal*3)/4) && fakesteps < goal){ star.draw(dc);  goal3.draw(dc);}  
        else if (fakesteps >= goal ){ specialstar.draw(dc);  goal4.draw(dc);}      
        else{ star.draw(dc);}    
        

        if (minutes%2 == 0){
        eyes.draw(dc);
        
        }else {
            eyes2.draw(dc);
        }

       if (minutes%4 == 1){
        if (seconds%2 == 0){mouth1.draw(dc);}else{mouth2.draw(dc);}
       }
       else if (minutes%4 == 2){
        if (seconds%2 == 0){mouth4.draw(dc);}else{mouth2.draw(dc);}
       }
       else if (minutes%4 == 3){
        if (seconds%2 == 0){mouth3.draw(dc);}else{mouth2.draw(dc);}
       }
       else{if (seconds%2 == 0){mouth1.draw(dc);}else{mouth4.draw(dc);}}

        if (seconds%2 == 0){
         mouth1.locY = venus2Y;
         mouth2.locY = venus2Y;
         mouth3.locY = venus2Y;
         mouth4.locY = venus2Y;
         star.locY = venus2Y;
         egg.locY = venus2Y;
          baby.locY = venus2Y;
           specialstar.locY = venus2Y;
         eyes.locY = venus2Y;
         eyes2.locY = venus2Y;
        }else {
            mouth1.locY = venumovey;
            mouth2.locY = venumovey;
            mouth3.locY = venumovey;
            mouth4.locY = venumovey;
            star.locY = venumovey;
            eyes.locY = venumovey;
            eyes2.locY = venumovey;
            egg.locY = venumovey;
            baby.locY = venumovey;
           specialstar.locY =venumovey;
            
        }
        //Draw Moon Phase
        moon1.draw(dc);
        //These Rise/Set could Be Icons, but I chose Bitmaps
        risepic.draw(dc);
        setpic.draw(dc);
/*
              _                 _      _       
  ___ _ _  __| |  _  _ _ __  __| |__ _| |_ ___ 
 / -_) ' \/ _` | | || | '_ \/ _` / _` |  _/ -_)
 \___|_||_\__,_|  \_,_| .__/\__,_\__,_|\__\___|
                      |_|                      
*/

 }


  /*
     _    _                    _                                     
  __| |_ (_)_ _  ___ ___ ___  | |_  ___ _ _ ___ ___ __ ___ _ __  ___ 
 / _| ' \| | ' \/ -_|_-</ -_) | ' \/ _ \ '_/ _ (_-</ _/ _ \ '_ \/ -_)
 \__|_||_|_|_||_\___/__/\___| |_||_\___/_| \___/__/\__\___/ .__/\___|
                                                          |_|        
  */  

//Takes in Year % 12 and Gives A Rough Chinese Horoscope
//Not Totally Accurate if Month falls in January or February
//Look at the 2022-2030 Function below to see inaccuracies 

//You Could Use Ranges of DaysSinceEpoch To Make Accurate
//But I Took the lazy Route to save memory using a case switch

/* Also Here is a unused Happy Chinese New Year Message Function:  
if (month == 1 && day == 1 && year == 2022) {
        return "Happy Lunar New Year!";
      } else if (month == 0 && day == 22 && year == 2023) {
        return "Happy Lunar New Year!";
      } else if (month == 1 && day == 10 && year == 2024) {
        return "Happy Lunar New Year!";
      } else if (month == 0 && day == 29 && year == 2025) {
        return "Happy Lunar New Year!";
      } else if (month == 1 && day == 17 && year == 2026) {
        return "Happy Lunar New Year!";
      } else if (month == 1 && day == 7 && year == 2027) {
        return "Happy Lunar New Year!";
      } else if (month == 0 && day == 26 && year == 2028) {
        return "Happy Lunar New Year!";
      } else if (month == 1 && day == 13 && year == 2029) {
        return "Happy Lunar New Year!";
      } else if (month == 1 && day == 2 && year == 2030) {
        return "Happy Lunar New Year!";
*/
function getChineseYear(year){
    var value = ((((year).toNumber())%12).toNumber());
        switch(value){
            case 0:
                return "mon";
                  //break;
            case 1:
                return "roo";
                //break;  
            case 2:
                return "dog";
                //break;  
            case 3:
                return "pig";
                //break;  
            case 4:
                return "rat";
                //break;  
            case 5:
                return "ox";
                //break;  
            case 6:
                return "tig";
                //break;            
            case 7:
                return "rab";
                //break;
            case 8:
                return "dra";
                //break;
            case 9:
                return "sna";
                //break;
            case 10:
                return "hor";
                //break;
            case 11:
                return "goa";
                //break;                         
            default:
            return "dra";
            }
    }
/*
  __  __                 ___ _                 
 |  \/  |___  ___ _ _   | _ \ |_  __ _ ___ ___ 
 | |\/| / _ \/ _ \ ' \  |  _/ ' \/ _` (_-</ -_)
 |_|  |_\___/\___/_||_| |_| |_||_\__,_/__/\___|
 This is not Totally Accurate Either Sadly
 It can be improved, but I took the lazy Route 
 This is based on a Farmers Almanac -
 Which Moonphases are 3 Days Each instead of Modern 1 Day
 So it Will show Quarter Moon, Full Moon, and New Moon for 3 Days
 If you are only Drawing the Moon - Should be Fine

 If you want exact Moon Dates Here Are Github Functions for 2022-2030
 ((You can use these Javascript function directly in Monkey C- no changes needed))
 https://github.com/SarahBass/Javascript-Moon-Functions/blob/main/Newmoon.js
 https://github.com/SarahBass/Javascript-Moon-Functions/blob/main/FullMoon.js
*/
function getMoonPhase(year, month, day) {

      var c = 0;
      var e = 0;
      var jd = 0;
      var b = 0;

      if (month < 3) {
        year--;
        month += 12;
      }

      ++month;

      c = 365.25 * year;

      e = 30.6 * month;

      jd = c + e + day - 694039.09; //jd is total days elapsed

      jd /= 29.5305882; //divide by the moon cycle

      b = (jd).toNumber(); //int(jd) -> b, take integer part of jd

      jd -= b; //subtract integer part to leave fractional part of original jd

      b = Math.round(jd * 8); //scale fraction from 0-8 and round

      if (b >= 8) {
        b = 0; //0 and 8 are the same so turn 8 into 0
      }
     //Return a Monkey C Number
      return (b).toNumber();
    }
/*
  ____        _ _           __  __         _   _    
 |_  /___  __| (_)__ _ __  |  \/  |___ _ _| |_| |_  
  / // _ \/ _` | / _` / _| | |\/| / _ \ ' \  _| ' \ 
 /___\___/\__,_|_\__,_\__| |_|  |_\___/_||_\__|_||_|
                                                    
*/

function getHoroscope(month, day) {

     if (month == 0) {
        if (day > 0 && day < 19) {
          return "Cap";
        } else {
          return "Aqu";
        }
      } else if (month == 1) {
        if (day > 1 && day < 18) {
          return "Cap";
        } else {
          return "Pis";
        }
      } else if (month == 2) {
        if (day > 1 && day < 20) {
          return "Pis";
        } else {
          return "Ari";
        }
      } else if (month == 3) {
        if (day > 1 && day < 19) {
          return "Ari";
        } else {
          return "Tau";
        }
      } else if (month == 4) {
        return "Tau";
      } else if (month == 5) {
        if (day > 1 && day < 20) {
          return "Gem";
        } else {
          return "Can";
        }
      } else if (month == 6) {
        if (day > 1 && day < 22) {
          return "Can";
        } else {
          return "Leo";
        }
      } else if (month == 7) {
        if (day > 1 && day < 22) {
          return "Leo";
        } else {
          return "Vir";
        }
      } else if (month == 8) {
        if (day > 1 && day < 22) {
          return "Vir";
        } else {
          return "Lib";
        }
      } else if (month == 9) {
        if (day > 1 && day < 22) {
          return "Lib";
        } else {
          return "Sco";
        }
      } else if (month == 10) {
        if (day > 1 && day < 21) {
          return "Sco";
        } else {
          return "Sag";
        }
      } else if (month == 11) {
        if (day > 1 && day < 21) {
          return "Sag";
        } else {
          return "Cap";
        }
      } else {
        return "Ari";
      }
    }
/*
  _  _              _     ___      _       
 | || |___ __ _ _ _| |_  | _ \__ _| |_ ___ 
 | __ / -_) _` | '_|  _| |   / _` |  _/ -_)
 |_||_\___\__,_|_|  \__| |_|_\__,_|\__\___|
                                           
*/
function getIterator() {
    // Check device for SensorHistory compatibility
    if ((Toybox has :SensorHistory) && (Toybox.SensorHistory has :getHeartRateHistory)) {
        return Toybox.SensorHistory.getHeartRateHistory({});
    }
    return null;
}

/*
   ___                _       __   __   _    _  
  / __|__ _ _ _ _ __ (_)_ _   \ \ / /__(_)__| | 
 | (_ / _` | '_| '  \| | ' \   \ V / _ \ / _` | 
  \___\__,_|_| |_|_|_|_|_||_|   \_/\___/_\__,_| 
                                                
*/

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void { }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

    //Foreground View as blank for energy save
    //and to not burn screen
    function onShow() as Void { }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void { }

}
 
