import Toybox.Lang;
import Toybox.WatchUi;

class MainDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        var settingsView = new SettingsView();
        // Switches the screen to settings view by holding up button
        WatchUi.pushView(settingsView, new SettingsDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    function onSelect() as Boolean {
        WatchUi.pushView(
            new StartRecordingView(),
            new StartRecordingDelegate(),
            WatchUi.SLIDE_UP
        );
        return true;
    }
}