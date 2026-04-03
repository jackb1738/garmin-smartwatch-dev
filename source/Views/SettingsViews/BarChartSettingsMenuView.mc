import Toybox.Graphics;
import Toybox.WatchUi;

class BarChartSettingsMenuView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    function onUpdate(dc as Dc) as Void {
        
        // Makes screen black and clears it
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();

        // gets screen dimensions
        var width = dc.getWidth();
        var height = dc.getHeight();

        // draws "Settings" text in the center of the screen
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            width / 2,
            height / 2,
            Graphics.FONT_MEDIUM,
            "Change bar chart length",
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
        );
    }
}