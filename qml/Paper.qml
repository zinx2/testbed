import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "Resources.js" as R

Rectangle {

    property bool visibleBackBtn : true
    property bool visibleSearchBtn : true
    property string titleText : opt.ds ? R.string_title : md.title
    signal evtBack()
    signal evtSearch()

    width: opt.ds ? R.design_size_width : parent.width
    height: opt.ds ? R.design_size_height : parent.height

    Rectangle
    {
        id: titleBar
        height: R.height_titlaBar
        width: parent.width
        color: R.color_appTitlebar

        CPButton
        {
            id: btnBack
            x: 0; y: 0
            visible: visibleBackBtn
            width: parent.height
            height: parent.height
            sourceWidth: R.dp(100)
            sourceHeight: R.dp(100)
            type: "image"
            onClicked:
            {
                evtBack()
            }
        }

        Label
        {
            width: parent.width
            height: parent.height
            text: titleText
            color: R.color_appTitleText
            horizontalAlignment : Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: R.pt(24)
            font.family: fontNanumBarunGothic.name
            FontLoader {
                id: fontNanumBarunGothic
                source: R.os() === "android" ? R.font("NanumBarunGothic_android.ttf") : R.font("NanumBarunGothic_ios.ttf")
            }
        }

        CPButton
        {
            id: btnSearch
            anchors
            {
                right: parent.right
            }

            visible: visibleSearchBtn
            width: parent.height
            height: parent.height
            sourceWidth: R.dp(100)
            sourceHeight: R.dp(100)
            imageSource: R.image("search_white.png")
            type: "image"
            onClicked:
            {
                if (Qt.inputMethod.visible)
                    Qt.inputMethod.hide()

                evtSearch()
            }
        }
    }

    Rectangle
    {
        id: busyArea
        width: parent.width
        height: parent.height
        color: "transparent"
        //        opacity: 0.7
        visible: false
        z: 9999

        Column
        {
            width: parent.width
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: parent.width*0.5 - busyIndi.width + R.dp(20)
            }
            CPBusyIndicatorEKr
            {
                id: busyIndi
            }
            LYMargin {
                height: R.dp(100)
            }
        }

        MouseArea
        {
            id: ma
            width: parent.width
            height: parent.height
            onClicked: busy(false);
        }
    }

    function busy(isBusy)
    {
        busyArea.visible = isBusy;
        busyIndi.running = isBusy;
    }

    property bool doQuit: false
    Timer
    {
        id: doQuitControl
        interval:1500
        repeat: false
        onTriggered: {
            doQuit = false
        }
    }

    Keys.onBackPressed:
    {
        if (Qt.inputMethod.visible)
        {
            Qt.inputMethod.hide()
            return;
        }

        if(popupStack.depth > 0)
        {
            popupStack.clear();
            return;
        }

        if(homeStackView.depth > 1)
            homeStackView.pop();
        else
        {
            if(!doQuit)
            {
                toast("한번 더 누르면 앱을 종료합니다.");
                doQuit = true;
                doQuitControl.start();
            }
            else
                Qt.quit();
        }
    }
}
