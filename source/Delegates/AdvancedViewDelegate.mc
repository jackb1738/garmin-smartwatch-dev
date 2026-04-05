import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Application;

class AdvancedViewDelegate extends WatchUi.BehaviorDelegate { 

    function initialize(view as AdvancedView) {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        // Open settings menu from advanced view long press UP
        pushSettingsView();
        
        return true;
    }

    function onKey(keyEvent as WatchUi.KeyEvent) as Boolean {
        var key = keyEvent.getKey();

        // Scroll down to SimpleView (completing the loop)
        if(key == WatchUi.KEY_DOWN) {
            pushSimpleView();
            return true;
        }
        // UP button - Back to SimpleView
        else if (key == WatchUi.KEY_UP) {
            pushSimpleView();
            return true;
        }

        return false;
    }

    function onSwipe(swipeEvent as WatchUi.SwipeEvent) as Boolean {
        var direction = swipeEvent.getDirection();
        
        // Swipe DOWN - Back to SimpleView
        if (direction == WatchUi.SWIPE_DOWN) {
            System.println("[UI] Swiped down to SimpleView");
            WatchUi.popView(WatchUi.SLIDE_UP);
            return true;
        }

        // Swipe LEFT - Settings
        if (direction == WatchUi.SWIPE_LEFT) {
            pushSettingsView();
            return true;
        }

        return false;
    }

    function onBack() as Boolean {
        // return to simple view
        pushSimpleView();
        return true;
    }

    function pushSettingsView() as Void {
        WatchUi.switchToView(new SettingsView(), new SettingsMenuDelegate(), WatchUi.SLIDE_UP);
    }

    function pushSimpleView() as Void {
        WatchUi.switchToView(new SimpleView(), new SimpleViewDelegate(), WatchUi.SLIDE_UP);
    }

}
