import QtQuick 2.0
import QtQuick.Controls 1.4
import "Resources.js" as R
Rectangle
{
    signal evtBack()
    signal evtCallback(variant obj)

    //    width: R.design_size_width
    //    height: R.design_size_height
    color: "#44000000"

    MouseArea
    {
        width: parent.width
        height: parent.height
        onClicked:
        {
            evtBack()
        }
    }

    Rectangle
    {
        id: popup
        width: parent.width * 0.8
        height: parent.height * 0.8 + R.height_titlaBar
        color: "white"
        //        radius: 5
        //        border.width: 1
        anchors
        {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }

        Column
        {
            width: parent.width
            height: parent.height

            Rectangle
            {
                id: titleBar
                height: R.height_titlaBar
                width: parent.width
                color: R.color_appTitlebar

                CPButton
                {
                    id: btnBack
                    width: parent.height
                    height: parent.height
                    sourceWidth: R.dp(100)
                    sourceHeight: R.dp(100)
                    imageSource: R.image("close_white.png")
                    type: "image"
                    onClicked:
                    {
                        evtBack()
                    }
                    anchors
                    {
                        right: parent.right
                    }
                }

                Label
                {
                    width: parent.width
                    height: parent.height
                    text: "공학변수 선택"
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
            }

            Loader
            {
                id: loader
                width: parent.width
                height: parent.height - titleBar.height
            }

            Component
            {
                id: component
                Flickable
                {
                    width: parent.width
                    height: parent.height - titleBar.height
                    interactive: false
                    ScrollView
                    {
                        clip: true
                        width: parent.width
                        height: parent.height
                        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
//                        verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff
                        anchors
                        {
                            //                    verticalCenter: parent.verticalCenter
                            horizontalCenter: parent.horizontalCenter
                        }

                        Column
                        {
                            Repeater
                            {
                                id: repeater
                                model: opt.ds ? ds_model : md.eng
                                Rectangle
                                {
                                    width: popup.width
                                    height: R.dp(120) + 1
                                    color: ma.pressed ? R.color_buttonPressed : "white"

                                    Column
                                    {
                                        width: parent.width
                                        height: parent.height
                                        Rectangle
                                        {
                                            width: parent.width
                                            height: parent.height - 1
                                            color: "transparent"
                                            CPText {
                                                verticalAlignment: Text.AlignVCenter
                                                horizontalAlignment: Text.AlignLeft
                                                height: parent.height
                                                font.pointSize: R.pt(15)
                                                text: opt.ds ? name : "   " + ((model.modelData.id+1) + ". " + model.modelData.name)
                                            }
                                        }
                                        Rectangle
                                        {
                                            width: parent.width
                                            height: 1
                                            color: index === (md.eng.length-1) ? "white" : "black"
                                        }
                                    }

                                    MouseArea
                                    {
                                        id: ma
                                        width: parent.width
                                        height: parent.height
                                        onClicked:
                                        {
                                            var obj = {
                                                "no" : (opt.ds ? number : (model.modelData.id + 1)) + ". ",
                                                "name" : opt.ds ? name : model.modelData.name
                                            }

                                            evtCallback(obj);
                                            evtBack();
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted:
    {
        viewTrigger.start();
    }
    Timer
    {
        id: viewTrigger
        interval: 100
        repeat: false
        onTriggered:
        {
            loader.sourceComponent = component;
        }
    }

    ListModel {
        id: ds_model
        ListElement {
            name: "Bill Smith"
            number: "0"
            content: "conttetwetpwfjpwefpojwepofjw234234pojefconttetwetpwfjpwefpojwepofjwpojefconttetwetpwfjpwefpojwepofjwpojefconttetwetpwfjpwefpojwepofjwpojefconttetwetpwfjpwefpojwepofjwpojefconttetwetpwfjpwefpojwepofjwpojefconttetwetpwfjpwefpojwepofjwpojefconttetwetpwfjpwefpojwepofjwpojefconttetwetpwfjpwefpojwepofjwpojefconttetwetpwfjpwefpojwepofjwpojefconttetwetpwfjpwefpojwepofjwpojefconttetwetpwfjpwefpojwepofjwpojef555"
            text: "AAA"
        }
        ListElement {
            name: "John Brown"
            number: "1"
            content: "conttetwetpwfjpwefpojwepofjwpojef"
            text: "BBB"
        }
        ListElement {
            name: "Sam Wise"
            number: "2"
            content: "conttetwetpwfjpwefpojwepofjwpojef"
            text: "CCC"
        }
        ListElement {
            name: "Bill Smith"
            number: "3"
            content: "conttetwetpwfjpwefpojwepofjwpojef"
            text: "DDD"
        }
        ListElement {
            name: "John Brown"
            number: "4"
            content: "conttetwetpwfjpwefpojwepofjwpojef"
            text: "EEE"
        }
        ListElement {
            name: "Sam Wise"
            number: "5"
            content: "conttetwetpwfjpwefpojwepofjwpojef"
            text: "FFF"
        }
        ListElement {
            name: "Bill Smith"
            number: "6"
            content: "conttetwetpwfjpwefpojwepofjwpojef"
        }
        ListElement {
            name: "John Brown"
            number: "7"
            content: "conttetwetpwfjpwefpojwepofjwpojef"
        }
        ListElement {
            name: "Sam Wise"
            number: "8"
            content: "conttetwetpwfjpwefpojwepofjwpojef"
        }
        ListElement {
            name: "Bill Smith"
            number: "9"
            content: "conttetwetpwfjpwefpojwepofjwpojef"
        }
        ListElement {
            name: "John Brown"
            number: "10"
            content: "conttetwetpwfjpwefpojwepofjwpojef"
        }
        ListElement {
            name: "Sam Wise"
            number: "11"
            content: "conttetwetpwfjpwefpojwepofjwpojef"
        }
        ListElement {
            name: "Bill Smith"
            number: "12"
            content: "conttetwetpwfjpwefpojwepofjwpojef"
        }
        ListElement {
            name: "John Brown"
            number: "13"
            content: "conttetwetpwfjpwefpojwepofjwpojef"
        }
        ListElement {
            name: "Sam Wise"
            number: "14"
            content: "conttetwetpwfjpwefpojwepofjwpojef"
        }
        ListElement {
            name: "Bill Smith"
            number: "15"
            content: "conttetwetpwfjpwefpojwepofjwpojef"
        }
        ListElement {
            name: "John Brown"
            number: "16"
            content: "conttetwetpwfjpwefpojwepofjwpojef"
        }
        ListElement {
            name: "Sam Wise"
            number: "17"
            content: "conttetwetpwfjpwefpojwepofjwpojef"
        }
        ListElement {
            name: "Bill Smith"
            number: "18"
            content: "conttetwetpwfjpwefpojwepofjwpojef"
        }
        ListElement {
            name: "John Brown"
            number: "19"
            content: "conttetwetpwfjpwefpojwepofjwpojef"
        }
        ListElement {
            name: "Sam Wise"
            number: "20"
            content: "conttetwetpwfjpwefpojwepofjwpojef"
        }
        ListElement {
            name: "Bill Smith"
            number: "21"
            content: "conttetwetpwfjpwefpojwepofjwpojef"
        }
        ListElement {
            name: "John Brown"
            number: "22"
            content: "conttetwetpwfjpwefpojwepofjwpojef"
        }
        ListElement {
            name: "Sam Wise"
            number: "23"
            content: "conttetwetpwfjpwefpojwepofjwpojef"
        }
    }
}
