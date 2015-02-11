/**
 * Created by angel777d on 10.02.2015.
 */
package controller {
import flash.display.Stage;
import flash.events.MouseEvent;

import model.Node;

import view.NodeView;

/**
 * Class implements nodes drag functionality
 */
public class DragController {
    private var stage:Stage;
    private var currentNode:Node;

    public function DragController(stage:Stage) {
        this.stage = stage;
        addListners();
    }

    private function addListners():void {
        stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
    }

    private function onMouseDown(event:MouseEvent):void {
        trace(event);
        if (event.target is NodeView) {
            currentNode = (event.target as NodeView).node;
        }
        if (currentNode) {
            stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
        }
    }

    private function onMouseUp(event:MouseEvent):void {
        trace(event);
        if (currentNode) {
            currentNode = null;
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
        }
    }


    private function onMove(event:MouseEvent):void {
        currentNode.setPosition(event.stageX - Config.width / 2, event.stageY - Config.height / 2);
    }
}
}
