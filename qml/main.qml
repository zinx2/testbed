import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import "Resources.js" as R

ApplicationWindow {
    id: appWindow
    visible: true
    width: 1500
    height: 888
    title: qsTr("Triz 40 Cartoon")



    Component.onCompleted: {

        //toast("본 앱에 포함된 카툰의 저작권은 GS인터비전에 있으니 무단 복제를 금합니다.");
        fadeoutTimer.running = true;
        console.log(R.design_size_width)
    }

    StackView
    {
        id: userStackView
        anchors.fill: parent
        visible: !settings.logined

        initialItem: PGLoginDesk
        {
            width: opt.ds ? R.design_size_width : userStackView.width
            height: opt.ds ? R.design_size_height : userStackView.height

            Component.onCompleted: {
                /* When Logined... AutoLogin. */
                console.log("Component.onCompleted : " + settings.logined);
                if(settings.logined) {
                    homeStackView.clear();
                    homeStackView.push(Qt.createComponent(R.view_file_home), { });
                }
            }
        }
    }

    StackView
    {
        id: homeStackView
        anchors.fill: parent
        visible: settings.logined
    }

    StackView
    {
        id: popupStack
        z: 9998
    }

    PGSplash
    {
        id: splashView
    }

    Timer
    {
        id:fadeoutTimer
        interval:2000
        repeat: false
        onTriggered:{
            splashView.opacity = 0;
            hideTimer.start();
        }
    }
    Timer
    {
        id:hideTimer
        interval:800
        repeat: false
        onTriggered: {
            splashView.visible=false;
        }
    }


    CPToast
    {
        id: toastPopup
        anchors
        {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: R.dp(150)
        }
//        visible: false
    }

    function toast(message)
    {
        toastPopup.show(message);
    }

    function popup(component/*src*/, properties, callback)
    {
        //        var component = Qt.createComponent(src);
        if(component.status == Component.Ready)
        {
            if(typeof properties === "undefined" || properties === null) properties = {"x":0, "y":0}

            //            var obj = Qt.createComponent(src).createObject(this, properties);
            var obj = component.createObject(this, properties);
            if(obj === null || typeof obj === "undefined") return;
            obj.evtBack.connect(function() {
                popupStack.clear()
            });
            obj.evtCallback.connect(callback);

            popupStack.push(obj, StackView.Immediate);
        }
    }
}

