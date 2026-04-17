using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;

class StartRecordingView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    function onLayout(dc as Graphics.Dc) as Void {
        dc.clear();

        var width = dc.getWidth();
        var height = dc.getHeight();

        dc.drawText(
            width / 2,
            height / 2 - 30,
            Graphics.FONT_SMALL,
            "Do you want to",
            Graphics.TEXT_JUSTIFY_CENTER
        );

        dc.drawText(
            width / 2,
            height / 2,
            Graphics.FONT_SMALL,
            "start recording?",
            Graphics.TEXT_JUSTIFY_CENTER
        );

        dc.drawText(
            width / 2,
            height / 2 + 40,
            Graphics.FONT_XTINY,
            "START = Yes    BACK = No",
            Graphics.TEXT_JUSTIFY_CENTER
        );
    }

    function onShow() as Void {
        System.println("StartRecordingView shown");
    }
}