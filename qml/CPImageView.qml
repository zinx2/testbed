import QtQuick 2.0
import "Resources.js" as R
Rectangle {

    property string imageSource: R.image("principe_1.png");
    Image
    {
        source: imageSource
        anchors
        {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        sourceSize.width: parent.width//(R.dp(R.design_size_width) - R.dp(300))
//        sourceSize.height: parent.height
        fillMode: Image.PreserveAspectFit
    }

}
