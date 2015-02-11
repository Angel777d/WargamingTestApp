package {

import controller.DragController;

import flash.display.Sprite;
import flash.display.StageScaleMode;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import model.Link;

import model.Model;
import model.Node;

import view.LinkView;

import view.NodeView;

public class Main extends Sprite {

    private var _model:Model = new Model();
    private var _drag:DragController;

    public function Main() {
        super();
        init();
        addListeners();
    }

    private function init():void {
        //setup stage
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.doubleClickEnabled = true;
        stage.frameRate = 60;
        //setup nodes drag controller
        _drag = new DragController(stage);
        //text field to explain how it works;
        var tf:TextField = new TextField();
        addChild(tf);
        tf.text = "Double click to create Rectangle.\r\nLeft click for action.\r\nRight click for cancel";
        tf.autoSize = TextFieldAutoSize.CENTER;
        tf.mouseEnabled = false;
    }

    private function addListeners():void {
        //add mouse listeners
        stage.addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);
        stage.addEventListener(MouseEvent.CLICK, onLeftClick);
        stage.addEventListener(MouseEvent.RIGHT_CLICK, onRightClick);
    }


    private function doubleClickHandler(event:MouseEvent):void {
        trace(event);
        var node:Node = _model.createNode(event.stageX - Config.width / 2, event.stageY - Config.height / 2);
        //if node cant be created - don't create it
        if (!node) return;
        //if it can, create ne node and add it to stage
        var nodeView:NodeView = new NodeView(node);
        addChild(nodeView);
        //and update node position
        node.update();
    }

    private function onLeftClick(event:MouseEvent):void {
        trace(event);
        //try to create link
        var nodeView:NodeView = event.target as NodeView;
        var link:Link = nodeView ? _model.addLinkTo(nodeView.node) : null;
        //check if link created and add new linkView to stage
        if (!link) return;
        var linkView:LinkView = new LinkView(link);
        addChild(linkView);
        link.update();
    }

    private function onRightClick(event:MouseEvent):void {
        trace(event);
        //event.preventDefault();
        var nodeView:NodeView = event.target as NodeView;
        if (!nodeView) return;
        var node:Node = nodeView.node;
        if (node.selected) node.selected = false;
        else if (node.haveLinks) {
            node.removeLinks();
        }
        else {
            _model.removeNode(node);
        }

    }


}
}
