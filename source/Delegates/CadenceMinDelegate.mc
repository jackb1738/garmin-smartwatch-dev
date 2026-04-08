import Toybox.WatchUi;
import Toybox.System;
import Toybox.Lang;


class CadenceMinDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onBack() as Boolean {
        System.println("[SETTINGS] CadenceMin: Back pressed - returning to SimpleView");
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
            System.println("[SETTINGS] CadenceMin: Up pressed");
            WatchUi.switchToView(
                new SimpleView(),
                new SimpleViewDelegate(),
                WatchUi.SLIDE_DOWN
            );
            return true;
        }


        if (key == WatchUi.KEY_DOWN) {
            System.println("[SETTINGS] CadenceMin: Down pressed - going to CadenceMaxView");
            WatchUi.switchToView(
                new CadenceMaxView(),
                new CadenceMaxDelegate(),
                WatchUi.SLIDE_UP
            );
            return true;
        }

        return false;
    }
}
