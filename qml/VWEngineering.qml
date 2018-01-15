import QtQuick 2.0
import QtQuick.Controls 2.2
import "Resources.js" as R

Paper {
    id: mainView
    visibleBackBtn: true
    //        width: R.design_size_width
    //        height: R.design_size_heightf


    Loader
    {
        id: loader
        width: parent.width
        height: parent.height
    }

    Component
    {
        id: component
        Column
        {
            width: parent.width
            height: parent.height - R.height_titlaBar
            y: R.height_titlaBar

            LYMargin
            {
                height: R.dp(30)
            }

            CPSubtitle
            {
                id: subtitle
                anchors
                {
                    left: parent.left
                    leftMargin: R.dp(30)
                }
                title : "공학변수별 설명"
            }

            LYMargin
            {
                height: R.dp(30)
            }

            Rectangle
            {
                width: parent.width
                height: parent.height
                color: "white"
                CPListView
                {
                    width: parent.width
                    height: parent.height
                }
            }
        }
    }

    onEvtBack:
    {
        stackView.pop();
    }

    Component.onCompleted:
    {
        viewTrigger.start();
    }

    Keys.onReleased : {
        console.log("Key pressed: "+event.key)
                if (event.key == Qt.Key_Back) {
                    console.log("Back button pressed.  Stack depth "+stackView.depth)
//                    if(stack.depth >= 1) {
//                        event.accepted = true
//                        stack.pop()
//                    }
//                    else
//                        event.accepted = false
                }
        if (event.key === Qt.Key_MediaPrevious)
            stackView.pop();
    }

    Timer
    {
        id: viewTrigger
        interval: 100
        repeat: false
        onTriggered:
        {
            md.initializeEngVisible();
            loader.sourceComponent = component;
        }
    }
}
