import Toybox.Application;
import Toybox.Graphics;
import Toybox.WatchUi;

class ProfileSettingsMenuView extends WatchUi.View {

    var _profileHeader;
    var _titleText;

    function initialize() {
        View.initialize();
        _profileHeader = Application.loadResource(Rez.Drawables.ProfileHeader);
        _titleText = "Profile Settings";
    }

    function onUpdate(dc as Dc) as Void {
        // Makes screen black and clears it
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();

        var width = dc.getWidth();
        var height = dc.getHeight();
        var headerWidth = _profileHeader.getWidth();
        var headerHeight = _profileHeader.getHeight();
        var headerX = (width - headerWidth) / 2;
        var headerY = (height / 2) - 92;

        if (headerY < 0) {
            headerY = 0;
        }

        dc.drawBitmap(
            headerX,
            headerY,
            _profileHeader
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
