import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.System;
import Toybox.Timer;
import Rez;

class VibrationView extends WatchUi.View {

    private var _enabled;
    private var _closeTimer;

    function initialize(enabled) {
        View.initialize();
        _enabled = enabled;
    }

    function onShow() as Void {
        _closeTimer = new Timer.Timer();
        _closeTimer.start(method(:closeMessage), 1200, false);
    }

    function onHide() as Void {
        if (_closeTimer != null) {
            _closeTimer.stop();
            _closeTimer = null;
        }
    }

    function closeMessage() as Void {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }

    function onUpdate(dc as Dc) as Void {
        var width = dc.getWidth();
        var height = dc.getHeight();

        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();

        var iconRes = _enabled ? Rez.Drawables.VibOnIcon : Rez.Drawables.VibOffIcon;
        var iconBmp = WatchUi.loadResource(iconRes);

        dc.drawBitmap(
            (width / 2) - (iconBmp.getWidth() / 2),
            (height / 2) - (iconBmp.getHeight() / 2),
            iconBmp
        );
    }
}