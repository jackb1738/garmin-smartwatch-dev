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
        // Clear to black
        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_BLACK);
        dc.clear();

        var width = dc.getWidth();
        
        var tickIcon = WatchUi.loadResource(Rez.Drawables.TickIcon);
        var crossIcon = WatchUi.loadResource(Rez.Drawables.CrossIcon);
        var recIcon = WatchUi.loadResource(Rez.Drawables.RecIcon);
        
        // title
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);

        // rec icon
        dc.drawBitmap(width / 2 - 18, 20, recIcon);

        dc.drawText(width / 2, 80, Graphics.FONT_SYSTEM_SMALL, "Do you want to", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(width / 2, 140, Graphics.FONT_SYSTEM_SMALL, "start recording?", Graphics.TEXT_JUSTIFY_CENTER);

        var yesY = 220; 
        var noY = 280;
        
        // Column 1: The Pointer Arrow (Far Left)
        var pointerX = (width / 2) - 60;
        // Column 2: The Icon (Middle Left)
        var iconX = (width / 2) - 30;
        // Column 3: The Text (Center-ish, pushing Right)
        var textX = (width / 2) + 10;
        
        var iconOffsetY = 14; // Pulls the image up to align with text


        // Yes option
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        
        // draw tick icon
        dc.drawBitmap(iconX, yesY - iconOffsetY, tickIcon);
        // Draw the text
        dc.drawText(textX, yesY, Graphics.FONT_SMALL, "Yes", Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);

        // draw pointer if selected
        if (_selectedOption == 0) {
            dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
            dc.drawText(pointerX, yesY, Graphics.FONT_SMALL, ">", Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
        }

        // No option
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        
        // draw cross icon
        dc.drawBitmap(iconX, noY - iconOffsetY, crossIcon);
        // Draw the text
        dc.drawText(textX, noY, Graphics.FONT_SMALL, "No", Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);

        // Draw pointer if selected
        if (_selectedOption == 1) {
            dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
            dc.drawText(pointerX, noY, Graphics.FONT_SMALL, ">", Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
        }
    }
}