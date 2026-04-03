import Toybox.Graphics;
import Toybox.WatchUi;
using Rez;

class StartConfirmView extends WatchUi.View {

    private var _selectedOption = 0; // 0 = Yes, 1 = No

    function initialize() {
        View.initialize();
    }

    function setSelectedOption(value) {
        _selectedOption = value;
    }

    function getSelectedOption() {
        return _selectedOption;
    }

    function onUpdate(dc) {
        dc.clear();

        var width = dc.getWidth();
        var tickIcon = WatchUi.loadResource(Rez.Drawables.TickIcon);
        var crossIcon = WatchUi.loadResource(Rez.Drawables.CrossIcon);
        var recIcon = WatchUi.loadResource(Rez.Drawables.RecIcon);
        

        // Title / question
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawBitmap(100, 20, recIcon);

        dc.drawText(
            width / 2,
            80,
            Graphics.FONT_SYSTEM_SMALL,
            "Do you want to",
            Graphics.TEXT_JUSTIFY_CENTER
        );

        dc.drawText(
            width / 2,
            140,
            Graphics.FONT_SYSTEM_SMALL,
            "Start recording?",
            Graphics.TEXT_JUSTIFY_CENTER
        );

        // YES option
        if (_selectedOption == 0) {
            dc.drawBitmap(width / 2 - 80, 212, tickIcon);
            dc.drawText(40, 230, Graphics.FONT_SMALL, "", Graphics.TEXT_JUSTIFY_LEFT);
        }
        dc.drawText(width / 2, 230, Graphics.FONT_SMALL, "Yes", Graphics.TEXT_JUSTIFY_CENTER);

        // NO option
        if (_selectedOption == 1) {
            dc.drawBitmap(20, 140, crossIcon);
            dc.drawText(40, 310, Graphics.FONT_SMALL, ">", Graphics.TEXT_JUSTIFY_LEFT);
        }
        dc.drawText(width / 2, 310, Graphics.FONT_SMALL, "No", Graphics.TEXT_JUSTIFY_CENTER);
    }
}