import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Timer;

class SimpleViewDelegate extends WatchUi.BehaviorDelegate {

    private var _currentView = null;
    private var _initTime = null;
    private var _menuActive = false;
    private var _lastUpPressTime = 0;
    private var _upPressTimer as Timer.Timer?;
    private static const DOUBLE_PRESS_WINDOW = 300;

    function initialize() {
        BehaviorDelegate.initialize();
        _initTime = System.getTimer();
    }

    function onMenu() as Boolean {
        pushSettingsView();
        return true;
    }

    function onSelect() as Boolean {
        System.println("[DEBUG] onSelect called, menuActive=" + _menuActive);
        
        if (_initTime != null && (System.getTimer() - _initTime) < 1000) {
            System.println("[DEBUG] Ignoring onSelect during initialization");
            return false;
        }
        
        if (_menuActive) {
            System.println("[DEBUG] Menu active, letting menu delegate handle it");
            return false;
        }
        
        System.println("[DEBUG] Handling START/STOP button press");
        return handleStartStopButton();
    }

    function handleStartStopButton() as Boolean {
        var app = getApp();

        if (app.isIdle()) {
            var view = new StartConfirmView();
            WatchUi.pushView(view, new StartConfirmViewDelegate(view), WatchUi.SLIDE_UP);
            WatchUi.requestUpdate();
        } 
        else if (app.isRecording()) {
            _menuActive = true;
            showActivityControlMenu();
        } 
        else if (app.isPaused()) {
            _menuActive = true;
            showPausedControlMenu();
        }
        else if (app.isStopped()) {
            _menuActive = true;
            showSaveDiscardMenu();
        }
        return true;
    }

    function onKey(keyEvent as WatchUi.KeyEvent) as Boolean {
        var key = keyEvent.getKey();

        if (key == WatchUi.KEY_DOWN) {
            _currentView = new AdvancedView();
            WatchUi.pushView(
                _currentView,
                new AdvancedViewDelegate(_currentView),
                WatchUi.SLIDE_DOWN
            );
            return true;
        }



    if (key == WatchUi.KEY_UP) {
    var currentTime = System.getTimer();
    System.println("[SimpleViewDelegate] UP pressed");

    if (currentTime - _lastUpPressTime < DOUBLE_PRESS_WINDOW) {
        var app = getApp();
        var enabled = app.getVibrationEnabled();
        app.setVibrationEnabled(!enabled);

        System.println("[SimpleViewDelegate] Vibration toggled: " + (!enabled).toString());

        // optional visual feedback
        // Vibration toggled, no visual feedback needed

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
    pushSettingsView();
}

function showVibrationStatus(enabled as Boolean) as Void {
    WatchUi.pushView(
        new VibrationView(enabled),
        new TimeViewDelegate(),
        WatchUi.SLIDE_IMMEDIATE
    );
}



    function onSwipe(event as WatchUi.SwipeEvent) as Boolean {
        var direction = event.getDirection();

        if (direction == WatchUi.SWIPE_UP) {
            _currentView = new AdvancedView();
            WatchUi.pushView(
                _currentView,
                new AdvancedViewDelegate(_currentView),
                WatchUi.SLIDE_DOWN
            );
            return true;
        }

        if (direction == WatchUi.SWIPE_LEFT) {
            pushSettingsView();
            return true;
        }

        return false;
    }

    function showActivityControlMenu() as Void {
        var menu = new WatchUi.Menu2({ :title => "Activity" });
        menu.addItem(new WatchUi.MenuItem("Resume", "Continue", :resume_activity, null));
        menu.addItem(new WatchUi.MenuItem("Pause", "Pause activity", :pause_activity, null));
        menu.addItem(new WatchUi.MenuItem("Stop", "Stop activity", :stop_activity, null));
        
        WatchUi.pushView(menu, new ActivityControlMenuDelegate(self), WatchUi.SLIDE_UP);
    }

    function showPausedControlMenu() as Void {
        var menu = new WatchUi.Menu2({ :title => "Activity Paused" });
        menu.addItem(new WatchUi.MenuItem("Resume", "Continue", :resume_activity, null));
        menu.addItem(new WatchUi.MenuItem("Stop", "Stop activity", :stop_activity, null));
        
        WatchUi.pushView(menu, new ActivityControlMenuDelegate(self), WatchUi.SLIDE_UP);
    }

    function showSaveDiscardMenu() as Void {
        var menu = new WatchUi.Menu2({ :title => "Save Activity?" });
        menu.addItem(new WatchUi.MenuItem("Save", "Save session", :save_session, null));
        menu.addItem(new WatchUi.MenuItem("Discard", "Discard session", :discard_session, null));
        
        WatchUi.pushView(menu, new SaveDiscardMenuDelegate(self), WatchUi.SLIDE_UP);
    }

    function pushSettingsView() as Void {

        WatchUi.switchToView(new SettingsView(), new SettingsMenuDelegate(), WatchUi.SLIDE_UP);
    }

    function setMenuActive(active as Boolean) as Void {
        _menuActive = active;
        System.println("[DEBUG] Menu active state set to: " + active);
    }

    function onBack() as Boolean {
        var app = getApp();
        
        if (app.isRecording() || app.isPaused() || app.isStopped()) {
            System.println("[UI] Session active - use Stop to exit");
            return true;
        }
        
        return false;
    }

       function onPreviousPage() as Boolean {
    var currentTime = System.getTimer();
    System.println("[SimpleViewDelegate] UP pressed via onPreviousPage");

    if (_lastUpPressTime != 0 && (currentTime - _lastUpPressTime) < DOUBLE_PRESS_WINDOW) {
        if (_upPressTimer != null) {
            _upPressTimer.stop();
            _upPressTimer = null;
        }

        var app = getApp();
        var enabled = app.getVibrationEnabled();
        var newEnabled = !enabled;
        app.setVibrationEnabled(newEnabled);

        System.println("[SimpleViewDelegate] Vibration toggled: " + newEnabled.toString());

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
}

class ActivityControlMenuDelegate extends WatchUi.Menu2InputDelegate {
    
    private var _parentDelegate;

    function initialize(parentDelegate) {
        Menu2InputDelegate.initialize();
        _parentDelegate = parentDelegate;
    }

    function onSelect(item as WatchUi.MenuItem) as Void {
        var id = item.getId();
        var app = getApp();

        System.println("[DEBUG] Menu item selected: " + id);

        if (id == :pause_activity) {
            app.pauseRecording();
            System.println("[UI] Activity paused");
            _parentDelegate.setMenuActive(false);
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            WatchUi.requestUpdate();
            
        } else if (id == :resume_activity) {
            if (app.isPaused()) {
                app.resumeRecording();
                System.println("[UI] Activity resumed");
            }
            _parentDelegate.setMenuActive(false);
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            WatchUi.requestUpdate();
            
        } else if (id == :stop_activity) {
            app.stopRecording();
            System.println("[UI] Activity stopped");
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            
            var menu = new WatchUi.Menu2({ :title => "Save Activity?" });
            menu.addItem(new WatchUi.MenuItem("Save", "Save session", :save_session, null));
            menu.addItem(new WatchUi.MenuItem("Discard", "Discard session", :discard_session, null));
            WatchUi.pushView(menu, new SaveDiscardMenuDelegate(_parentDelegate), WatchUi.SLIDE_UP);
        }
    }

    function onBack() as Void {
        _parentDelegate.setMenuActive(false);
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}

class SaveDiscardMenuDelegate extends WatchUi.Menu2InputDelegate {
    
    private var _parentDelegate;

    function initialize(parentDelegate) {
        Menu2InputDelegate.initialize();
        _parentDelegate = parentDelegate;
    }

    function onSelect(item as WatchUi.MenuItem) as Void {
        var id = item.getId();
        var app = getApp();

        System.println("[DEBUG] Save/Discard selected: " + id);

        if (id == :save_session) {
             app.saveSession();
             System.println("[UI] Activity saved");
            _parentDelegate.setMenuActive(false);

    // 🔥 SHOW SUMMARY SCREEN INSTEAD OF CONFIRMATION
             WatchUi.switchToView(
             new SummaryView(),
             new SummaryViewDelegate(),
             WatchUi.SLIDE_UP
    );
        } else if (id == :discard_session) {
            app.discardSession();
            System.println("[UI] Activity discarded");
            _parentDelegate.setMenuActive(false);
            
            var confirmationMenu = new WatchUi.Menu2({ :title => "Activity Discarded" });
            confirmationMenu.addItem(new WatchUi.MenuItem("Done", null, :done, null));
            WatchUi.pushView(confirmationMenu, new ConfirmationDelegate(_parentDelegate), WatchUi.SLIDE_IMMEDIATE);
        }
        
        WatchUi.requestUpdate();
    }

    function onBack() as Void {
    }
}

class ConfirmationDelegate extends WatchUi.Menu2InputDelegate {
    
    private var _parentDelegate;

    function initialize(parentDelegate) {
        Menu2InputDelegate.initialize();
        _parentDelegate = parentDelegate;
    }

    function onSelect(item as WatchUi.MenuItem) as Void {
        _parentDelegate.setMenuActive(false);
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
    
    function onBack() as Void {
        _parentDelegate.setMenuActive(false);
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}
