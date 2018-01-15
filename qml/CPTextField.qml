import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
import "Resources.js" as R
TextField
{

    signal evtBack();
    signal evtSearch();

    activeFocusOnPress: false
    maximumLength: 50
    placeholderText: "검색어를 입력하세요..."
    font.pointSize: R.pt(18)
    color: "black"

    background: Rectangle {
        border.color: "white"
    }

    font.family: fontNanumBarunGothic.name
    FontLoader {
        id: fontNanumBarunGothic
        source: R.os() === "android" ? R.font("NanumBarunGothic_android.ttf") : R.font("NanumBarunGothic_ios.ttf")
    }

    onPressed:
    {
        activeFocusOnPress = true
        focus = true
    }

    onEditingFinished:
    {
        evtSearch();
        leaveFocus()
    }

    Keys.onBackPressed:
    {
        evtBack();
        leaveFocus()
    }

    function leaveFocus()
    {
        focus = false;
        activeFocusOnPress = false
    }
}
