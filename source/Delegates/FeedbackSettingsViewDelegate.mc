import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class FeedbackSettingsViewDelegate extends WatchUi.BehaviorDelegate {

    private var _view;

    function initialize(view) {
        BehaviorDelegate.initialize();
        _view = view;
    }

    function onKey(keyEvent) as Boolean {
        var key = keyEvent.getKey();
        System.println("[FEEDBACK-SETTINGS] Key pressed: " + key);

        if (key == WatchUi.KEY_UP) {
            _view.onUp();
            WatchUi.requestUpdate();
            System.println("[FEEDBACK-SETTINGS] Moved to ON");
            return true;
        }

        if (key == WatchUi.KEY_DOWN) {
            _view.onDown();
            WatchUi.requestUpdate();
            System.println("[FEEDBACK-SETTINGS] Moved to OFF");
            return true;
        }

        return false;
    }

    function onSelect() as Boolean {
        System.println("[FEEDBACK-SETTINGS] START button pressed - confirming selection");
        _view.onStart();
        return true;
    }

    function onTap(clickEvent as WatchUi.ClickEvent) as Boolean {
        System.println("[FEEDBACK-SETTINGS] Screen tapped - confirming selection");
        _view.onStart();
        return true;
    }

    function onSwipe(swipeEvent) as Boolean {
        var direction = swipeEvent.getDirection();
        System.println("[FEEDBACK-SETTINGS] Swipe detected: " + direction);

        if (direction == WatchUi.SWIPE_DOWN) {
            _view.onUp();
            WatchUi.requestUpdate();
            System.println("[FEEDBACK-SETTINGS] Swiped down - selected ON");
            return true;
        }

        if (direction == WatchUi.SWIPE_UP) {
            _view.onDown();
            WatchUi.requestUpdate();
            System.println("[FEEDBACK-SETTINGS] Swiped up - selected OFF");
            return true;
        }

        return false;
    }

    function onBack() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
        return true;
    }
}
