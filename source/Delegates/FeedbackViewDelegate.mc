import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class FeedbackViewDelegate extends WatchUi.BehaviorDelegate {

    private var _view;
    private var _lastOpenTime;

    function initialize() {
        BehaviorDelegate.initialize();
        _view = null;
        _lastOpenTime = 0;
    }

    function setView(view) as Void {
        _view = view;
    }

    function onSelect() as Boolean {
        System.println("[FEEDBACK] SELECT button pressed - opening settings");
        return openSettings();
    }

    function onMenu() as Boolean {
        System.println("[FEEDBACK] MENU button pressed - opening settings");
        return openSettings();
    }

    function onTap(clickEvent as WatchUi.ClickEvent) as Boolean {
        System.println("[FEEDBACK] Screen tapped - opening settings");
        return openSettings();
    }

    function onKey(keyEvent as WatchUi.KeyEvent) as Boolean {
        var key = keyEvent.getKey();
        System.println("[FEEDBACK] Key pressed: " + key);

        return handleKey(key, "pressed");
    }

    function onKeyPressed(keyEvent as WatchUi.KeyEvent) as Boolean {
        return handleKey(keyEvent.getKey(), "pressed");
    }

    function onKeyReleased(keyEvent as WatchUi.KeyEvent) as Boolean {
        return handleKey(keyEvent.getKey(), "released");
    }

    function onSwipe(swipeEvent as WatchUi.SwipeEvent) as Boolean {
        var direction = swipeEvent.getDirection();
        System.println("[FEEDBACK] Swipe detected: " + direction);

        if (direction == WatchUi.SWIPE_DOWN || direction == WatchUi.SWIPE_UP) {
            return openSettings();
        }

        return false;
    }

    function handleKey(key, action) as Boolean {
        System.println("[FEEDBACK] Key " + action + ": " + key);

        System.println("[FEEDBACK] Opening settings from key " + action);
        return openSettings();
    }

    function openSettings() as Boolean {
        var now = System.getTimer();
        if (_lastOpenTime != 0 && (now - _lastOpenTime) < 500) {
            return true;
        }

        _lastOpenTime = now;

        if (_view != null) {
            _view.openSettings();
        } else {
            var settingsView = new FeedbackSettingsView();
            WatchUi.pushView(settingsView, new FeedbackSettingsViewDelegate(settingsView), WatchUi.SLIDE_UP);
        }
        WatchUi.requestUpdate();
        return true;
    }

    function onBack() as Boolean {
        return true;
    }
}
