import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "Resources.js" as R

Paper {
    id: mainView
    visibleBackBtn: false
    visibleSearchBtn: false

    property bool initTab1 : false
    property bool initTab2 : false
    property bool initTab3 : false
    property bool initTab4 : false

    property bool logouted : opt.ds ? false : !settings.logined
    onLogoutedChanged: {
        if(logouted) {
            stackView.clear();
            stackView.push(Qt.createComponent(R.view_file_loginDesk), { });
        }
    }

    Component.onCompleted:
    {
        loader.sourceComponent = componentTab1;
    }

    Column
    {
        id: ccca
        width: parent.width
        height: parent.height - (R.height_titlaBar + 1)
        y: R.height_titlaBar + 1

        Loader
        {
            id: loader
            width: parent.width
            height: parent.height - R.dp(160)
        }

        Component
        {
            id: componentTab1
            PGTab1
            {
                width: parent.width
                height: parent.height - R.dp(160)
            }
        }

        Component
        {
            id: componentTab2
            PGTab2
            {
                width: parent.width
                height: parent.height - R.dp(160)
            }
        }

        Component
        {
            id: componentTab3
            PGTab3
            {
                width: parent.width
                height: parent.height - R.dp(160)
            }
        }

        Component
        {
            id: componentTab4
            PGTab4
            {
                width: parent.width
                height: parent.height - R.dp(160)
            }
        }

        Rectangle
        {
            width: parent.width
            height: R.dp(160)

            Row
            {
                width: parent.width
                height: parent.height
                spacing: 1
                CPButton
                {
                    sourceWidth: parent.width / 4
                    sourceHeight: parent.height
                    btnName: "메뉴1"
                    rectColor: R.color_buttonColor001
                    textColor: "white"
                    onClicked:
                    {
                        /* DESIGN LOGIC */
                        if(opt.ds)
                        {
                            return; /* PLEASE DON'T REMVOE! */
                        }
                        loader.sourceComponent = componentTab1;
                    }
                }
                CPButton
                {
                    sourceWidth: parent.width / 4
                    sourceHeight: parent.height
                    btnName: "메뉴2"
                    rectColor: R.color_buttonColor001
                    textColor: "white"
                    onClicked:
                    {
                        /* DESIGN LOGIC */
                        if(opt.ds)
                        {
                            return; /* PLEASE DON'T REMVOE! */
                        }
                        loader.sourceComponent = componentTab2;
                    }
                }
                CPButton
                {
                    sourceWidth: parent.width / 4
                    sourceHeight: parent.height
                    btnName: "메뉴3"
                    rectColor: R.color_buttonColor001
                    textColor: "white"
                    onClicked:
                    {
                        /* DESIGN LOGIC */
                        if(opt.ds)
                        {
                            return; /* PLEASE DON'T REMVOE! */
                        }
                        loader.sourceComponent = componentTab3;
                    }
                }
                CPButton
                {
                    sourceWidth: parent.width / 4
                    sourceHeight: parent.height
                    btnName: "메뉴4"
                    rectColor: R.color_buttonColor001
                    textColor: "white"
                    onClicked:
                    {
                        /* DESIGN LOGIC */
                        if(opt.ds)
                        {
                            return; /* PLEASE DON'T REMVOE! */
                        }
                        loader.sourceComponent = componentTab4;
                    }
                }
            }
        }
    }

}

