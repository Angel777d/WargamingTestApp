/**
 * Created by angel777d on 09.02.2015.
 */
package view {

import flash.display.Sprite;
import flash.events.Event;

import model.Node;


public class NodeView extends Sprite {
    private var _node:Node;

    public function NodeView(node:Node) {
        super();
        _node = node;
        _node.addEventListener("update", onUpdate);
        _node.addEventListener("remove", onRemove);
        draw();
    }

    private function update():void {
        x = _node.x;
        y = _node.y;
    }

    private function onUpdate(event:Event):void {
        update();
        if (node.redraw) draw();
    }

    private function onRemove(event:Event):void {
        parent.removeChild(this);
    }


    private function draw():void {
        graphics.clear();
        graphics.beginFill(_node.color, 1);
        graphics.drawRect(0, 0, _node.width, _node.height);
        graphics.endFill();

        if (!node.selected) return;

        graphics.lineStyle(2, 0);
        graphics.drawRect(0, 0, _node.width, _node.height);

    }

    public function get node():Node {
        return _node;
    }
}
}
