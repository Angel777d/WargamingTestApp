/**
 * Created by angel777d on 09.02.2015.
 */
package view {
import flash.display.Shape;
import flash.events.Event;
import flash.geom.Point;

import model.Link;
import model.Node;

public class LinkView extends Shape {

    private var link:Link;

    public function LinkView(link:Link) {
        super();
        this.link = link;
        link.addEventListener("update", onUpdate);
        link.addEventListener("remove", onRemove);
    }

    private function onUpdate(event:Event):void {
        var start:Point = link.getStartPoint();
        x = start.x;
        y = start.y;
        redraw();
    }

    private function onRemove(event:Event):void {
        parent.removeChild(this);
    }

    private function redraw():void {
        var endPoint:Point = link.getEndPoint();
        graphics.clear();
        graphics.lineStyle(2, 0);
        graphics.lineTo(endPoint.x, endPoint.y);
    }

}
}
