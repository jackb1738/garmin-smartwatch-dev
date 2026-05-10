import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.System;

class FeedbackView extends WatchUi.View {

    function initialize() {
        View.initialize();
        System.println("[FEEDBACK-VIEW] FeedbackView initialized");
    }

    function onSelect() as Boolean {
        System.println("[FEEDBACK-VIEW] SELECT pressed - opening settings");
        return openSettings();
    }

    function onTap(clickEvent as WatchUi.ClickEvent) as Boolean {
        System.println("[FEEDBACK-VIEW] Screen tapped - opening settings");
        return openSettings();
    }

    function openSettings() as Boolean {
        var settingsView = new FeedbackSettingsView();
        WatchUi.pushView(settingsView, new FeedbackSettingsViewDelegate(settingsView), WatchUi.SLIDE_UP);
        return true;
    }

    function onUpdate(dc as Dc) as Void {
        System.println("[FEEDBACK-VIEW] onUpdate called - drawing feedback screen");
        dc.clear();

        var width = dc.getWidth();
        var height = dc.getHeight();
        var centerX = width / 2;
        var centerY = height / 2;

        // Background
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.fillRectangle(0, 0, width, height);

        // Load and draw the feedback-loop icon.
        var feedbackIcon = WatchUi.loadResource(Rez.Drawables.FeedbackLoop);
        var iconX = centerX - feedbackIcon.getWidth() / 2;
        var iconY = centerY - feedbackIcon.getHeight() / 2 - 52;
        dc.drawBitmap(iconX, iconY, feedbackIcon);

        // Title
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(centerX, centerY + 28, Graphics.FONT_SMALL, "Feedback", Graphics.TEXT_JUSTIFY_CENTER);

        // Tap hint
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(centerX, centerY + 52, Graphics.FONT_SYSTEM_SMALL, "tap to open", Graphics.TEXT_JUSTIFY_CENTER);
    }
}
