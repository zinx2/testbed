import QtQuick 2.7
import "Resources.js" as R

Rectangle
{
    width: parent.width
    height: parent.height
    visible: true
    color: R.color_bgColor002

    Column
    {
        id: ekoreaTextArea
        width: ekoreaText.contentWidth
        anchors
        {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        Rectangle
        {
            width: ekoreaText.contentWidth
            height: ekoreaText.contentHeight
            color: "transparent"

            CPText
            {
                id: ekoreaText
                font.pointSize: R.pt(50)
                font.bold: true
                color: "white"
                text: "e-koreatech"
                horizontalAlignment: Text.AlignHCenter
            }
        }
        LYMargin { height: R.dp(60) }
    }

    CPBusyIndicatorEKr
    {
        anchors
        {
            bottom: ekoreaTextArea.top
            right: ekoreaTextArea.right
            rightMargin: R.dp(50)
            bottomMargin: R.dp(10)
        }
    }
}
