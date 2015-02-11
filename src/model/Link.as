/**
 * Created by angel777d on 09.02.2015.
 */
package model {
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.geom.Point;

[Event(name="update", type="flash.events.Event")]
[Event(name="remove", type="flash.events.Event")]
public class Link extends EventDispatcher {

    private var node:Node;
    private var node1:Node;

    public function Link(node:Node, node1:Node) {
        this.node = node;
        this.node1 = node1;
        updateNodes();
    }

    private function updateNodes():void {
        node.addLink(this);
        node1.addLink(this);
    }

    private function dispatchUpdate():void {
        dispatchEvent(new Event("update"));
    }

    private function dispatchRemove():void {
        dispatchEvent(new Event("remove"));
    }

    public function remove():void {
        node.removeLink(this);
        node1.removeLink(this);
        dispatchRemove();
    }

    /**
     * Method can be used for update link view
     */
    public function update():void {
        dispatchUpdate();
    }

    /**
     * First node position getter
     * @return Point center of first node position
     */
    public function getStartPoint():Point {
        return new Point(node.x + Config.width / 2, node.y + Config.height / 2);
    }

    /**
     * Second node local position center. Can be used to draw line from start point
     * @return Point of line end
     */
    public function getEndPoint():Point {
        return new Point(node1.x - node.x, node1.y - node.y);
    }

    /**
     * method to indicate nodes linked with this
     * @param someNode
     * @param otherNode
     * @return true if current nodes linked by this link
     */
    public function connectedNodes(someNode:Node, otherNode:Node):Boolean {
        if (node == someNode && node1 == otherNode) return true;
        if (node1 == someNode && node == otherNode) return true;
        return false
    }

}
}
