import QtQuick 2.0
import "Resources.js" as R

Row
{
    property string title : "sample"

    width: parent.width
    height: R.dp(48)
    spacing: R.dp(20)

    Image
    {
        source: R.image("rectangle.png");
        width: R.dp(48)
        height: R.dp(48)
        anchors.verticalCenter: parent.verticalCenter
    }

    CPText
    {
        text: title
        font.pointSize: R.pt(23)
        anchors.verticalCenter: parent.verticalCenter
    }
}
