import QtQuick 2.7
import "Resources.js" as R

Rectangle
{
    anchors.fill: parent
    visible: true
    Image
    {
        anchors.centerIn: parent
        width: R.dp(184)
        height: R.dp(349)
        source: R.image("splash.png")
    }
    Behavior on opacity { NumberAnimation { duration: 1000 ;easing.type: Easing.InQuad}  }
}
