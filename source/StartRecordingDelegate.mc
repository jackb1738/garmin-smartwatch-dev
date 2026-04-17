using Toybox.WatchUi;
using Toybox.System;
using Toybox.Lang;

class StartRecordingDelegate extends WatchUi.InputDelegate {

    function initialize() {
        InputDelegate.initialize();
    }

    function onKey(keyEvent as WatchUi.KeyEvent) as Lang.Boolean {

        var keyCode = keyEvent.getKey();

        if (keyCode == WatchUi.KEY_START) {
            System.println("Recording Started");
            getApp().startRecording();
            WatchUi.popView(WatchUi.SLIDE_DOWN);
            return true;
        }

        if (keyCode == WatchUi.KEY_ESC) {
            System.println("Recording Cancelled");
            WatchUi.popView(WatchUi.SLIDE_DOWN);
            return true;
        }

        return false;
    }
}