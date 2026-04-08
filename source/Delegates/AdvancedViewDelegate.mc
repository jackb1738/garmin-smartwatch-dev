import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Application;
import Toybox.Timer;

class AdvancedViewDelegate extends WatchUi.BehaviorDelegate { 


    private var _lastUpPressTime = 0;
    private var _upPressTimer as Timer.Timer?;
    const DOUBLE_PRESS_WINDOW = 500;

    function initialize(view as AdvancedView) {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        // Create programmatic Menu2 instead of XML-based menu
        var app = Application.getApp() as GarminApp;
        var minCadence = app.getMinCadence();
        var maxCadence = app.getMaxCadence();
        
        var menu = new WatchUi.Menu2({
            :title => Lang.format("Cadence: $1$ - $2$", [minCadence, maxCadence])
        });
        
        menu.addItem(new WatchUi.MenuItem("Set Min Cadence", null, :item_set_min, null));
        menu.addItem(new WatchUi.MenuItem("Set Max Cadence", null, :item_set_max, null));
        
        WatchUi.pushView(menu, new SelectCadenceDelegate(menu), WatchUi.SLIDE_BLINK);
        
        return true;
    }

  function onKey(keyEvent as WatchUi.KeyEvent) as Boolean {
    var key = keyEvent.getKey();
    System.println("[AdvancedViewDelegate] Key pressed: " + key.toString());

    if (key == WatchUi.KEY_DOWN) {
        WatchUi.switchToView(
            new SimpleView(),
            new SimpleViewDelegate(),
            WatchUi.SLIDE_DOWN
        );
        return true;
    }

    if (key == WatchUi.KEY_UP) {
    var currentTime = System.getTimer();
    System.println("[AdvancedViewDelegate] UP pressed");

    if (currentTime - _lastUpPressTime < DOUBLE_PRESS_WINDOW) {
        var app = Application.getApp() as GarminApp;
        var enabled = app.getVibrationEnabled();
        app.setVibrationEnabled(!enabled);

        System.println("[HAPTIC] Vibration toggled: " + (!enabled).toString());

        _lastUpPressTime = 0;
        return true;
    }

    _lastUpPressTime = currentTime;
    return true;
}

    return false;
}

function handleSingleUpPress() as Void {
    _lastUpPressTime = 0;

    WatchUi.switchToView(
        new SimpleView(),
        new SimpleViewDelegate(),
        WatchUi.SLIDE_UP
    );
}

function showVibrationStatus(enabled as Boolean) as Void {
    WatchUi.pushView(
        new VibrationView(enabled),
        new TimeViewDelegate(),
        WatchUi.SLIDE_IMMEDIATE
    );
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
        // Back button disabled - no input
        return true;
    }

    function pushSettingsView() as Void {
        var settingsMenu = new WatchUi.Menu2({ :title => "Settings" });
        settingsMenu.addItem(new WatchUi.MenuItem("Profile", null, :set_profile, null));
        settingsMenu.addItem(new WatchUi.MenuItem("Customization", null, :cust_options, null));
        settingsMenu.addItem(new WatchUi.MenuItem("Feedback", null, :feedback_options, null));
        settingsMenu.addItem(new WatchUi.MenuItem("Cadence Range", null, :cadence_range, null));

        WatchUi.pushView(settingsMenu, new SettingsMenuDelegate(), WatchUi.SLIDE_UP);
    }

    function onPreviousPage() as Boolean {
    var currentTime = System.getTimer();
    System.println("[AdvancedViewDelegate] UP pressed via onPreviousPage");

    if (_lastUpPressTime != 0 && (currentTime - _lastUpPressTime) < DOUBLE_PRESS_WINDOW) {
        if (_upPressTimer != null) {
            _upPressTimer.stop();
            _upPressTimer = null;
        }

        var app = Application.getApp() as GarminApp;
        var enabled = app.getVibrationEnabled();
        var newEnabled = !enabled;
        app.setVibrationEnabled(newEnabled);

        System.println("[AdvancedViewDelegate] Vibration toggled: " + newEnabled.toString());

        _lastUpPressTime = 0;
        showVibrationStatus(newEnabled);
        return true;
    }

    _lastUpPressTime = currentTime;

    if (_upPressTimer != null) {
        _upPressTimer.stop();
    }

    _upPressTimer = new Timer.Timer();
    _upPressTimer.start(method(:handleSingleUpPress), DOUBLE_PRESS_WINDOW, false);

    return true;
}

    function onNextPage() as Boolean {
        WatchUi.switchToView(
            new SimpleView(),
            new SimpleViewDelegate(),
            WatchUi.SLIDE_DOWN
        );
        return true;
    }
}
