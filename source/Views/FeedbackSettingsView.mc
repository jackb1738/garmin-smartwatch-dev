import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.System;

class FeedbackSettingsView extends WatchUi.View {

    var feedbackOn = true;
    var selected = 0; // 0 = ON, 1 = OFF

    function initialize() {
        View.initialize();
        System.println("[FEEDBACK-SETTINGS-VIEW] FeedbackSettingsView initialized");
    }

    function onUpdate(dc as Dc) as Void {
        System.println("[FEEDBACK-SETTINGS-VIEW] onUpdate called - drawing settings screen");
        dc.clear();

        var width = dc.getWidth();
        var height = dc.getHeight();
        var centerX = width / 2;
        var centerY = height / 2;

        // Background
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.fillRectangle(0, 0, width, height);

        // Header
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(centerX, centerY - 92, Graphics.FONT_XTINY, "Current Feedback:", Graphics.TEXT_JUSTIFY_CENTER);
        dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
        dc.drawText(centerX, centerY - 66, Graphics.FONT_XTINY, feedbackOn ? "ON" : "OFF", Graphics.TEXT_JUSTIFY_CENTER);

        // Option list
        var optionX = centerX - 88;
        var optionY = centerY - 18;
        var optionSpacing = 28;
        var markerX = optionX;
        var textX = optionX + 16;

        // ON option
        dc.setColor(selected == 0 ? Graphics.COLOR_WHITE : Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(textX, optionY, Graphics.FONT_XTINY, "ON", Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);

        // OFF option
        dc.setColor(selected == 1 ? Graphics.COLOR_WHITE : Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(textX, optionY + optionSpacing, Graphics.FONT_XTINY, "OFF", Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);

        // Selection indicator
        dc.setColor(0x00FFFF, Graphics.COLOR_TRANSPARENT);
        if (selected == 0) {
            dc.fillRectangle(markerX, optionY - 8, 3, 18);
        } else {
            dc.fillRectangle(markerX, optionY + optionSpacing - 8, 3, 18);
        }

        // Footer note
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(centerX, centerY + 66, Graphics.FONT_XTINY, "press START to confirm", Graphics.TEXT_JUSTIFY_CENTER);
    }

    function onUp() {
        selected = 0;
        feedbackOn = true;
        System.println("[FEEDBACK-SETTINGS-VIEW] onUp called - selected: " + (selected == 0 ? "ON" : "OFF"));
        WatchUi.requestUpdate();
    }

    function onDown() {
        selected = 1;
        feedbackOn = false;
        System.println("[FEEDBACK-SETTINGS-VIEW] onDown called - selected: " + (selected == 0 ? "ON" : "OFF"));
        WatchUi.requestUpdate();
    }

    function onStart() {
        feedbackOn = (selected == 0);
        System.println("[FEEDBACK-SETTINGS-VIEW] onStart called - saved: " + (feedbackOn ? "ON" : "OFF"));
        WatchUi.popView(WatchUi.SLIDE_DOWN);
    }
}
