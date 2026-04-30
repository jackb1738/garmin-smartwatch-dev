import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Application;

class SelectBarChartDelegate extends WatchUi.BehaviorDelegate {

    private var _options as Array<Number> = [5, 10, 20, 40];

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onBack() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
        return true;
    }

    function onSelect() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
        return true;
    }

    function onKey(keyEvent as WatchUi.KeyEvent) as Boolean {
        var key = keyEvent.getKey();
        var app = Application.getApp() as GarminApp;
        var current = app.getChartBarCount();
        var idx = _options.indexOf(current);

        if (key == WatchUi.KEY_UP) {
            if (idx > 0) { 
                app.setChartDuration(_options[idx - 1]); 
            } else { 
                app.setChartDuration(_options[_options.size() - 1]);
            }
            WatchUi.requestUpdate();
            return true;
        }

        if (key == WatchUi.KEY_DOWN) {
            if (idx < _options.size() - 1) { 
                app.setChartDuration(_options[idx + 1]); 
            } else { 
                app.setChartDuration(_options[0]); 
            }
            WatchUi.requestUpdate();
            return true;
        }

        return false;
    }
}