/**
 * Created by angel777d on 09.02.2015.
 */
package model {

import flash.geom.Point;
import flash.geom.Rectangle;

/**
 * Class implements nodes and links data model
 */
public class Model {

    private var nodes:Array = [];
    private var links:Array = [];

    public function Model() {
        super();
    }

    /**
     * method create new node if it possible.
     * @param x coord
     * @param y coord
     * @return new Node item or null if node  can't be created
     */
    public function createNode(x:int, y:int):Node {
        if (!canAdd(x, y)) return null;
        var node:Node = new Node(this).setPosition(x, y);
        nodes.push(node);
        return node;
    }

    /**
     * method to remove node from model. Also removes all node links
     * @param node
     * @return removed node instance
     */
    public function removeNode(node:Node):Node {
        nodes.splice(nodes.indexOf(node), 1);
        node.removeLinks();
        node.remove();
        return node;
    }

    /**
     * Method to create new link between two nodes
     * To create link have to be called twice - for each node
     * Mark first node as selected
     * @param parentNode node to be linked
     * @return new link or null if link cant be created
     */
    public function addLinkTo(parentNode:Node):Link {
        if (!parentNode) return null;
        var otherNode:Node = getSelectedNode(parentNode);
        if (otherNode) {
            if (otherNode.haveLinkWith(parentNode)) {
                parentNode.selected = false;
                otherNode.selected = false;
            }
            else {
                var link:Link = new Link(parentNode, otherNode);
                links.push(link);
                return link;
            }
        }
        parentNode.selected = true;
        return null;
    }

    /**
     * method removes link from model
     * @param link to remove
     * @return removed link
     */
    public function removeLink(link:Link) : Link {
        links.splice(nodes.indexOf(link), 1);
        link.remove();
        return link;
    }

    /**
     * Method to check if node can be moved to position
     * @param x new coord
     * @param y new coord
     * @param item Node to check
     * @return new Point coords of node or null if node cant be placed
     */
    public function moveCheck(x:int, y:int, item:Node):Point {
        var collisions:Array = getCollisions(x, y, item);
        if (collisions.length == 0) return new Point(x, y);
        //most simple point realised
        //if cant place item here - just don't move it
        //if we need more complex logic of node dragging it have to be implemented here
        return null;

    }

    private function canAdd(x:int, y:int):Boolean {
        return getCollisions(x, y).length == 0;
    }

    private function getCollisions(x:int, y:int, exclude:Node = null):Array {
        var rect:Rectangle = new Rectangle(x, y, Config.width, Config.height);
        var result:Array = [];
        for each (var item:Node in nodes) {
            if (item == exclude) continue;
            var otherRect:Rectangle = new Rectangle(item.x, item.y, Config.width, Config.height);
            if (rect.intersects(otherRect)) result.push(item);
        }
        return result;
    }

    private function getSelectedNode(exclude:Node = null):Node {
        for each (var item:Node in nodes) {
            if (item == exclude) continue;
            if (item.selected) return item;
        }
        return null;
    }

}
}
