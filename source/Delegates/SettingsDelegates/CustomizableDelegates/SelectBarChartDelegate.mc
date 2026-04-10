import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Application;

class SelectBarChartDelegate extends WatchUi.Menu2InputDelegate {

    var app = Application.getApp() as GarminApp;

    function initialize(menu as WatchUi.Menu2) {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) as Void {
        var id = item.getId();

        if (id == :chart_15m) {
            app.setChartDuration(3);   // FifteenminChart
            System.println("Chart Duration: Fifteenmin");
        }
        else if (id == :chart_30m) {
            app.setChartDuration(6);   // ThirtyminChart
            System.println("Chart Duration: Thirtymin");
        }
        else if (id == :chart_1h) {
            app.setChartDuration(13);  // OneHourChart
            System.println("Chart Duration: OneHour");
        }
        else if (id == :chart_2h) {
            app.setChartDuration(26);  // TwoHourChart
            System.println("Chart Duration: TwoHour");
        }
        else {
            System.println("ERROR");
        }

        WatchUi.requestUpdate();
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }

    function onMenuItem(item as Symbol) as Void {}

    function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }
}