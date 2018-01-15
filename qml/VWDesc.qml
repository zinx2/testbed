import QtQuick 2.0
import QtQuick.Controls 2.2
import "Resources.js" as R

Paper {

    property int no: opt.ds ? 0 : md.currentIndex
    property string subtitle: opt.ds ?
                                  "— Lyrics — I know just how to whisper And "
                                : md.getName(no)

    titleText: "40가지 발명 원리"


    id: mainView
    visibleBackBtn: true
    visibleSearchBtn: false

    Column
    {
        width: parent.width
        height: parent.height - R.height_titlaBar
        y: R.height_titlaBar

        Rectangle
        {
            id: subtitleBar
            width: parent.width
            height: txtSubtitle.contentHeight + R.dp(40)
            color: "orange"

            Row
            {
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
                    color: "white"
                    text: (no +1) + ". "
                }
                CPText
                {
                    id: txtSubtitle
                    width: parent.width - lb_no.contentWidth - R.dp(40)
                    height: txtSubtitle.contentHeight
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: R.pt(22)
                    color: "white"
                    text: subtitle
                }
            }
        }

        Row
        {
            width: parent.width
            height: parent.height - subtitleBar.height

            LYMargin { width: btnLeft.visible ? 0 : R.height_titlaBar }

            CPButton
            {
                id: btnLeft
                z:1000
                visible: no != 0
                width: R.height_titlaBar
                height: parent.height
                sourceWidth: R.dp(100)
                sourceHeight: R.dp(100)
                type: "image"
                imageSource: R.image("btn_pre.png")
                anchors.verticalCenter: parent.verticalCenter
                onClicked:
                {
                    no = no - 1;
                    if(!opt.ds)
                        md.setCurrentIndex(no)
                }
            }

            CPImageView
            {
                width: parent.width - R.height_titlaBar * 2
                height: parent.height - subtitleBar.height - subtitleBar.height
                imageSource: opt.ds ? R.image("principe_1.png") : R.image(md.getSrc(no) + ".png");
                anchors.verticalCenter: parent.verticalCenter
            }

            CPButton
            {
                id: btnRight
                z:1000
                visible: opt.ds ? (no != 3) : (no != md.size()-1)
                width: R.height_titlaBar
                height: parent.height
                sourceWidth: R.dp(100)
                sourceHeight: R.dp(100)
                type: "image"
                imageSource: R.image("btn_next.png")
                anchors.verticalCenter: parent.verticalCenter
                onClicked:
                {
                    no = no + 1;
                    if(!opt.ds)
                        md.setCurrentIndex(no)
                }
            }

        }
    }



    onEvtBack:
    {
        stackView.pop();
    }
}
