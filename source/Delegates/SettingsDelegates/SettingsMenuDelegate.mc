import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Application;

class SettingsMenuDelegate extends WatchUi.BehaviorDelegate { 

    function initialize() {
        WatchUi.BehaviorDelegate.initialize();
    }

    // Handles the BACK button
    function onBack() as Boolean{
        System.println("Back pressed: Returning to main view");

        WatchUi.pushView(new SimpleView(), new SimpleViewDelegate(), WatchUi.SLIDE_DOWN);
        return true;
    }

    // Handles the SELECT/START button (or screen tap)
    function onSelect() as Boolean {
        System.println("Select/Tap pressed: Opening feedback screen");
        
        pushFeedbackView(WatchUi.SLIDE_UP);
        return true;
    }

    function onTap(clickEvent as WatchUi.ClickEvent) as Boolean {
        System.println("Screen tapped: Opening feedback screen");
        
        pushFeedbackView(WatchUi.SLIDE_UP);
        return true;
    }

    // Handles the DOWN button (or swipe up)
    function onNextPage() as Boolean {
        System.println("Down button pressed");
        
        // Push the cadence settings view if the user scrolls down in the settings menu
        WatchUi.pushView(new CadenceSettingsMenuView(), new CadenceSettingsMenuDelegate(), WatchUi.SLIDE_UP);
        
        return true; 
    }

    // Handles the UP button (or swipe down)
    function onPreviousPage() as Boolean {
        System.println("Up button pressed");
        
        // Push the feedback view
        pushFeedbackView(WatchUi.SLIDE_DOWN);
        
        return true; 
    }

    function pushFeedbackView(slide) as Void {
        var feedbackView = new FeedbackView();
        var feedbackDelegate = new FeedbackViewDelegate();
        feedbackDelegate.setView(feedbackView);
        WatchUi.pushView(feedbackView, feedbackDelegate, slide);
    }

    // Explicit key handler for physical buttons
    function onKey(keyEvent as WatchUi.KeyEvent) as Boolean {
        var key = keyEvent.getKey();

        if (key == WatchUi.KEY_UP) {
            return onPreviousPage();
        }

        if (key == WatchUi.KEY_DOWN) {
            return onNextPage();
        }

        return false;
    }

}
