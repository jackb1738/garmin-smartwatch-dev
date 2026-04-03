import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Application;

class BarChartSettingsMenuDelegate extends WatchUi.BehaviorDelegate { 

    function initialize() {
        BehaviorDelegate.initialize();
    }

    // Handles the BACK button
    function onBack() as Boolean{
        System.println("Back pressed: Returning to main view");

        WatchUi.pushView(new SimpleView(), new SimpleViewDelegate(), WatchUi.SLIDE_DOWN);
        return true;
    }

    // Handles the SELECT/START button (or screen tap)
    function onSelect() as Boolean {
        System.println("Select/Tap pressed: Opening bar chart settings");
        
        // Push the bar chart settings
        pushBarChartMenu();
        return true;
    }

    // Handles the DOWN button (or swipe up)
    function onNextPage() as Boolean {
        System.println("Down button pressed");
        
        // Push the cadence settings view
        WatchUi.pushView(new SummarySettingsMenuView(), new SummarySettingsMenuDelegate(), WatchUi.SLIDE_UP);
        
        return true; 
    }

    // Handles the UP button (or swipe down)
    function onPreviousPage() as Boolean {
        System.println("Up button pressed");
        
        // Push the profile settings view
        WatchUi.pushView(new CadenceSettingsMenuView(), new CadenceSettingsMenuDelegate(), WatchUi.SLIDE_DOWN);
        
        return true; 
    }


    function pushBarChartMenu() as Void {
        var menu = new WatchUi.Menu2({
            :title => "Bar Chart Length:"
        });

        menu.addItem(new WatchUi.MenuItem("15 Minute", null, :chart_15m, null));
        menu.addItem(new WatchUi.MenuItem("30 Minute", null, :chart_30m, null));
        menu.addItem(new WatchUi.MenuItem("1 Hour", null, :chart_1h, null));
        menu.addItem(new WatchUi.MenuItem("2 Hour", null, :chart_2h, null));

        //pushes the view to the screen with the relevent delegate
        WatchUi.pushView(menu, new SelectBarChartDelegate(menu), WatchUi.SLIDE_LEFT);
    }
}