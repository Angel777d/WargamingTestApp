/**
 * Created by angel777d on 09.02.2015.
 */
package model {
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.geom.Point;

[Event(name="update", type="flash.events.Event")]
[Event(name="remove", type="flash.events.Event")]
public class Node extends EventDispatcher {


    private var _x:int, _y:int;
    private var _color:uint = 0xFFFFFF;
    private var _model:Model;

    private var _selected:Boolean = false;
    private var _redraw:Boolean = false;
    private var _links:Array = [];

    public function Node(model:Model) {
        _model = model;
        _color = Math.round(color * Math.random());
    }

    private function dispatchUpdate():void {
        dispatchEvent(new Event("update"));
    }

    private function dispatchRemove():void {
        dispatchEvent(new Event("remove"));
    }

    public function remove():void {
        dispatchRemove();
    }

    public function update(redraw:Boolean = false):void {
        _redraw = redraw;
        dispatchUpdate();
        _redraw = false;
    }

    public function get color():uint {
        return _color;
    }

    public function setPosition(x:int, y:int) {
        var newPoint:Point = _model.moveCheck(x, y, this);
        //don't move item if check failed
        if (!newPoint) return this;
        _x = newPoint.x;
        _y = newPoint.y;
        dispatchUpdate();
        updateLinks();
        return this;
    }

    private function updateLinks():void {
        for each (var link:Link in _links) {
            link.update();
        }
    }


    public function haveLinkWith(node:Node):Boolean {
        for each (var link:Link in _links) {
            if (link.connectedNodes(this, node)) return true;
        }
        return false;
    }


    public function set selected(value:Boolean):void {
        _selected = value;
        update(true);
    }

    public function addLink(value:Link):void {
        _links.push(value);
        _selected = false;
        update(true);
    }

    public function removeLinks():void {
        while (_links.length) {
            _model.removeLink(_links[0]);
        }
    }

    public function removeLink(value:Link):void {
        _links.splice(_links.indexOf(value), 1);
        _selected = false;
        update(true);
    }

    //======= simple getters ===================

    public function get redraw():Boolean {
        return _redraw;
    }

    public function get selected():Boolean {
        return _selected;
    }

    public function get x():int {
        return _x;
    }

    public function get y():int {
        return _y;
    }

    public function get width():int {
        return Config.width;
    }

    public function get height():int {
        return Config.height;
    }

    public function get haveLinks():Boolean {
        return _links.length > 0;
    }

}
}
