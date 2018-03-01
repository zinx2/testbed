import QtQuick 2.0
import "Resources.js" as R

ListView {
    id: listView
    clip: true
    property string footerSize : R.dp(500)
    model: opt.ds ? ds_model : md.list

    boundsBehavior: Flickable.StopAtBounds
    maximumFlickVelocity: R.design_size_height * 3
    cacheBuffer : R.design_size_height * 3
    delegate: Rectangle {

        width: listView.width
        height: visible ? txtSubtitle.contentHeight + R.dp(60) + 1 : 0
        visible: opt.ds ? vs : model.modelData.visibled

        property int no: opt.ds ? number : model.modelData.id
        property string title: opt.ds ? name : model.modelData.name
        color: ma.pressed ? R.color_buttonPressed : "white"

        Row
        {
            id: rowItem
            width: parent.width
            height: txtSubtitle.contentHeight
            anchors
            {
                left: parent.left
                leftMargin: R.dp(20)
                verticalCenter: parent.verticalCenter
            }
            CPText
            {
                id: lb_no
                font.pointSize: R.pt(22)
                height: txtSubtitle.contentHeight / txtSubtitle.lineCount
                verticalAlignment: Text.AlignVCenter
                color: "black"
                text: (no +1) + ". "
            }

            CPText
            {
                id: txtSubtitle
                width: parent.width - R.dp(120)
                height: txtSubtitle.contentHeight
                font.pointSize: R.pt(22)
                text: title
                verticalAlignment: Text.AlignVCenter
            }
        }


        LYMargin
        {
            width: parent.width
            color: "black"
            visible: (listView.model.count-1) != index
            anchors
            {
                bottom: parent.bottom
            }
        }

        MouseArea
        {
            id: ma
            width: parent.width
            height: parent.height
            onClicked:
            {
                if (Qt.inputMethod.visible)
                    Qt.inputMethod.hide()

                if(!opt.ds)
                {
                    md.setCurrentIndex(no);
                    //                    homeStackView.push(vwdesc);
                    homeStackView.push(Qt.createComponent(R.view_file_desc), { });
                }

            }
        }

    }

    header:Rectangle
    {
        width: listView.width
        height: R.dp(100)
        color: "orange"
        CPText
        {
            height:parent.height
            font.pointSize: R.pt(20)
            text: "40가지 발명 원리"
            verticalAlignment: Text.AlignVCenter
            color: "white"
            anchors
            {
                left: parent.left
                leftMargin: R.dp(20)
            }
        }
    }

    footer: LYMargin
    {
        height: footerSize
    }
}
