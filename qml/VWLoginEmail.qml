import QtQuick 2.9
import QtQuick.Controls 2.2
import "Resources.js" as R

Paper {
    titleText: "이메일 로그인"

    id: mainView
    visibleBackBtn: true
    visibleSearchBtn: false

    onEvtBack:
    {
        stackView.pop();
    }
}
