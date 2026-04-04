import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.System;
import Toybox.Timer;

class VibrationView extends WatchUi.View {

    private var _text;
    private var _timer;

    function initialize(text) {
    WatchUi.View.initialize();
    _text = text;
    }

    function onShow() as Void {
        _timer = new Timer.Timer();

        // Auto close after 2 seconds
        _timer.start(method(:closeView), 2000, false);
    }

    function onUpdate(dc as Dc) as Void {

        var w = dc.getWidth();
        var h = dc.getHeight();

        // Background
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.fillRectangle(0, 0, w, h);

        // Text
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.drawText(
            w/2,
            h/2,
            Graphics.FONT_LARGE,
            _text,
            Graphics.TEXT_JUSTIFY_CENTER
        );
    }

    function closeView() as Void {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }

    function onHide() as Void {
        if (_timer != null) {
            _timer.stop();
        }
    }
}