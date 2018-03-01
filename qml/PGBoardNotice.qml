import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "Resources.js" as R

Paper {
    id: mainView
    visibleSearchBtn: false
    titleText: "공지사항"

    onEvtBack:
    {
        homeStackView.pop();
        if(homeStackView.depth === 1)
            md.setBlockedDrawer(false);
    }
}
