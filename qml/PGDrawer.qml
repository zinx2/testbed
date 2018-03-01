import QtQuick 2.9
import QtQuick.Controls 2.2
import "Resources.js" as R

Drawer {
    id: drawer
    interactive : true
    dragMargin : md.blockedDrawer ? R.dp(0) : R.dp(50)
    position: md.openedDrawer ? 1.0 : 0.0


    Rectangle{
        id: content
        width: parent.width
        height: parent.height
        Column{
            spacing: 1
            width: parent.width
            height: parent.height
            CPButton
            {
                sourceWidth: parent.width
                sourceHeight: R.height_button_middle
                btnName: "내 강의실"
                rectColor: R.color_buttonColor001
                textColor: "white"
                onClicked:
                {
                    navi(R.view_file_myClassRoom);
                }
            }
            CPButton
            {
                sourceWidth: parent.width
                sourceHeight: R.height_button_middle
                btnName: "공지사항"
                rectColor: R.color_buttonColor001
                textColor: "white"
                onClicked:
                {
                    navi(R.view_file_boardNotice);
                }
            }
            CPButton
            {
                sourceWidth: parent.width
                sourceHeight: R.height_button_middle
                btnName: "질의응답"
                rectColor: R.color_buttonColor001
                textColor: "white"
                onClicked:
                {
                    navi(R.view_file_boardQnA);
                }
            }
            CPButton
            {
                sourceWidth: parent.width
                sourceHeight: R.height_button_middle
                btnName: "자료실"
                rectColor: R.color_buttonColor001
                textColor: "white"
                onClicked:
                {
                    navi(R.view_file_boardData);
                }
            }
            CPButton
            {
                sourceWidth: parent.width
                sourceHeight: R.height_button_middle
                btnName: "설정"
                rectColor: R.color_buttonColor001
                textColor: "white"
                onClicked:
                {
                    navi(R.view_file_option);
                }
            }
        }
    }

    function navi(filename)
    {
        homeStackView.push(Qt.createComponent(filename), {});
        md.setBlockedDrawer(true);
        md.setOpenedDrawer(false);
    }

}
