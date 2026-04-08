import Toybox.WatchUi;
import Toybox.System;
import Toybox.Lang;

class CadenceMaxDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onBack() as Boolean {
        System.println("[SETTINGS] CadenceMax: Back pressed - returning to SimpleView");
        WatchUi.switchToView(
            new SimpleView(),
            new SimpleViewDelegate(),
            WatchUi.SLIDE_DOWN
        );
        return true;
    }

    function onKey(keyEvent as WatchUi.KeyEvent) as Boolean {
        var key = keyEvent.getKey();

        if (key == WatchUi.KEY_UP) {
            System.println("[SETTINGS] CadenceMax: Up pressed - going to CadenceMinView");
            WatchUi.switchToView(
                new CadenceMinView(),
                new CadenceMinDelegate(),
                WatchUi.SLIDE_DOWN
            );
            return true;
        }

        if (key == WatchUi.KEY_DOWN) {
            System.println("[SETTINGS] CadenceMax: Down pressed");
            WatchUi.switchToView(
                new SimpleView(),
                new SimpleViewDelegate(),
                WatchUi.SLIDE_UP
            );
            return true;
        }

        return false;
    }
}
