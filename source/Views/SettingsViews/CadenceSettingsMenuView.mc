import Toybox.Application;
import Toybox.Graphics;
import Toybox.WatchUi;

class CadenceSettingsMenuView extends WatchUi.View {

    var _cadenceHeader;
    var _titleText;

    function initialize() {
        View.initialize();
        _cadenceHeader = Application.loadResource(Rez.Drawables.CadenceHeader);
        _titleText = "Cadence Range";
    }

    function onUpdate(dc as Dc) as Void {
        // Makes screen black and clears it
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();

        var width = dc.getWidth();
        var height = dc.getHeight();
        var headerWidth = _cadenceHeader.getWidth();
        var headerHeight = _cadenceHeader.getHeight();
        var headerX = (width - headerWidth) / 2;
        var headerY = ((height - headerHeight) / 2) - 18;

        if (headerY < 0) {
            headerY = 0;
        }

        dc.drawBitmap(
            headerX,
            headerY,
            _cadenceHeader
        );

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            width / 2,
            headerY + headerHeight + 12,
            Graphics.FONT_SMALL,
            _titleText,
            Graphics.TEXT_JUSTIFY_CENTER
        );
    }
}
