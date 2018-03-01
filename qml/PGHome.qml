import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "Resources.js" as R

Paper {
    id: mainView
    visibleBackBtn: false
    visibleSearchBtn: true
    titleText: "e-koreatech"

    property bool initTab1 : false
    property bool initTab2 : false
    property bool initTab3 : false
    property bool initTab4 : false

    Component.onCompleted:
    {
        loader.sourceComponent = componentTab1;
    }

    width: R.design_size_width
    height: R.design_size_height

    PGDrawer {
        id: drawer
        width: parent.width * 2 / 3
        height: parent.height
        interactive: settings.logined
    }

    Column
    {
        width: parent.width
        height: parent.height - (R.height_titlaBar + 1)
        y: R.height_titlaBar + 1
        spacing: 1

        ListModel {
            id: contactModel
            ListElement {
                imgPath: "image://async/img021.jpg"
            }
            ListElement {
                imgPath: "image://async/img038.jpg"
            }
            ListElement {
                imgPath: "image://async/img039.jpg"
            }
            ListElement {
                imgPath: "image://async/img040.jpg"
            }
        }

        Rectangle {
            id: viewPager
            width: parent.width
            height: R.dp(500)

            CPBusyIndicatorEKr {
                id: viewPagerBusy
                anchors {
                    left: parent.left
                    leftMargin: parent.width*0.5 - viewPagerBusy.width + R.dp(20)
                    verticalCenter: parent.verticalCenter
                }
            }

            PathView {
                id: pathView
                anchors.fill: parent
                model: contactModel
                delegate: CPImage {
                    source: imgPath
                    height : viewPager.height;
                    width: viewPager.width
                    fillMode: Image.PreserveAspectCrop
                    clip: true
                }


                path: Path {
                    startX: viewPager.width * (contactModel.count>1 ? -0.5 : 0.5)
                    startY: viewPager.height*0.5
                    PathLine {
                        x: viewPager.width * (contactModel.count>1 ? (contactModel.count - 0.5) : 0.501)
                        y: viewPager.height*0.5;
                    }
                }
            }

            PageIndicator
            {
                id: pageIndicator
                count: pathView.count
                currentIndex: pathView.currentIndex
                anchors
                {
                    bottom: viewPager.bottom
                    horizontalCenter: parent.horizontalCenter
                    bottomMargin: R.dp(20)
                }
                delegate: Rectangle {
                    implicitWidth: R.dp(25)
                    implicitHeight: R.dp(25)
                    radius: width
                    color: "gray"
                    opacity: index === pathView.currentIndex ? 1.0 : pressed ? 0.7 : 0.45
                }
            }

            Timer
            {
                id: pagerControl
                interval:5000
                running: true
                repeat: true
                onTriggered: {
                    if(pathView.currentIndex == pathView.count-1)
                        pathView.currentIndex = 0;
                    else
                        pathView.currentIndex += 1;

                    pageIndicator.currentIndex = pathView.currentIndex;
                }
            }

            Component.onCompleted:
            {
                if(pathView.count > 0) {
                    viewPagerBusy.visible = false;
                    viewPagerBusy.running = false;
                }
            }
        }

        Row
        {
            width: parent.width
            height: R.height_button_middle
            LYMargin
            {
                width: 1
            }

            CPButton
            {
                sourceWidth: parent.width * 0.5 - 1
                sourceHeight: R.height_button_middle
                btnName: "카카오 로그아웃"
                rectColor: R.color_buttonColor001
                textColor: "white"
                onClicked:
                {
                    /* DESIGN LOGIC */
                    if(opt.ds)
                    {
                        return; /* PLEASE DON'T REMVOE! */
                    }

                    /* NOT DESIGN LOGIC */
                    cmd.logoutKakao();
                }
            }

            LYMargin
            {
                width: 1
            }

            CPButton
            {
                sourceWidth: parent.width  * 0.5 - 1
                sourceHeight: R.height_button_middle
                btnName: "카카오 연결해제"
                rectColor: R.color_buttonColor001
                textColor: "white"
                onClicked:
                {
                    /* DESIGN LOGIC */
                    if(opt.ds)
                    {
                        return; /* PLEASE DON'T REMVOE! */
                    }

                    /* NOT DESIGN LOGIC */
                    cmd.withdrawKakao();
                }
            }
        }

        Row
        {
            width: parent.width
            height: R.height_button_middle
            LYMargin
            {
                width: 1
            }

            CPButton
            {
                sourceWidth: parent.width * 0.5 -1
                sourceHeight: R.height_button_middle
                btnName: "페이스북 로그아웃"
                rectColor: R.color_buttonColor001
                textColor: "white"
                onClicked:
                {
                    /* DESIGN LOGIC */
                    if(opt.ds)
                    {



                        return; /* PLEASE DON'T REMVOE! */
                    }

                    /* NOT DESIGN LOGIC */
                    cmd.logoutFacebook();
                }
            }
            LYMargin
            {
                width: 1
            }

            CPButton
            {
                sourceWidth: parent.width * 0.5 -1
                sourceHeight: R.height_button_middle
                btnName: "페이스북 연결해제"
                rectColor: R.color_buttonColor001
                textColor: "white"
                onClicked:
                {
                    /* DESIGN LOGIC */
                    if(opt.ds)
                    {



                        return; /* PLEASE DON'T REMVOE! */
                    }

                    /* NOT DESIGN LOGIC */
                    cmd.withdrawFacebook();
                }
            }
        }


        Row
        {
            width: parent.width
            height: R.height_button_middle
            LYMargin
            {
                width: 1
            }

            CPButton
            {
                sourceWidth: parent.width * 0.5 - 1
                sourceHeight: R.height_button_middle
                btnName: "카카오 초대하기"
                rectColor: R.color_buttonColor001
                textColor: "white"
                onClicked:
                {
                    /* DESIGN LOGIC */
                    if(opt.ds)
                    {



                        return; /* PLEASE DON'T REMVOE! */
                    }

                    /* NOT DESIGN LOGIC */
                    cmd.inviteKakao();
                }
            }
            LYMargin
            {
                width: 1
            }
            CPButton
            {
                sourceWidth: parent.width * 0.5 - 1
                sourceHeight: R.height_button_middle
                btnName: "페이스북 공유하기"
                rectColor: R.color_buttonColor001
                textColor: "white"
                onClicked:
                {
                    /* DESIGN LOGIC */
                    if(opt.ds)
                    {



                        return; /* PLEASE DON'T REMVOE! */
                    }

                    /* NOT DESIGN LOGIC */
                    cmd.inviteFacebook();
                }
            }
        }

        Row
        {
            width: parent.width
            height: R.height_button_middle
            LYMargin
            {
                width: 1
            }
            CPButton
            {
                sourceWidth: parent.width * 0.5 - 1
                sourceHeight: R.height_button_middle
                btnName: "인디케이터 테스트"
                rectColor: R.color_buttonColor001
                textColor: "white"
                onClicked:
                {
                    busy(true);
                }
            }
            LYMargin
            {
                width: 1
            }
            CPButton
            {
                sourceWidth: parent.width * 0.5 - 1
                sourceHeight: R.height_button_middle
                btnName: "슬라이드 메뉴 열기"
                rectColor: R.color_buttonColor001
                textColor: "white"
                onClicked:
                {
                    drawer.open();
                }
            }
        }

        Loader
        {
            id: loader
            width: parent.width
            height: parent.height /*- R.dp(160)*/
        }

        Component
        {
            id: componentTab1
            PGTab1
            {
                width: parent.width
                height: parent.height
            }
        }

        //        Component
        //        {
        //            id: componentTab2
        //            PGTab2
        //            {
        //                width: parent.width
        //                height: parent.height - R.dp(160)
        //            }
        //        }

        //        Component
        //        {
        //            id: componentTab3
        //            PGTab3
        //            {
        //                width: parent.width
        //                height: parent.height - R.dp(160)
        //            }
        //        }

        //        Component
        //        {
        //            id: componentTab4
        //            PGTab4
        //            {
        //                width: parent.width
        //                height: parent.height - R.dp(160)
        //            }
        //        }

        //        Rectangle
        //        {
        //            width: parent.width
        //            height: R.dp(160)

        //            Row
        //            {
        //                width: parent.width
        //                height: parent.height
        //                spacing: 1
        //                CPButton
        //                {
        //                    sourceWidth: parent.width / 4
        //                    sourceHeight: parent.height
        //                    btnName: "메뉴1"
        //                    rectColor: R.color_buttonColor001
        //                    textColor: "white"
        //                    onClicked:
        //                    {
        //                        /* DESIGN LOGIC */
        //                        if(opt.ds)
        //                        {
        //                            return; /* PLEASE DON'T REMVOE! */
        //                        }
        //                        loader.sourceComponent = componentTab1;
        //                    }
        //                }
        //                CPButton
        //                {
        //                    sourceWidth: parent.width / 4
        //                    sourceHeight: parent.height
        //                    btnName: "메뉴2"
        //                    rectColor: R.color_buttonColor001
        //                    textColor: "white"
        //                    onClicked:
        //                    {
        //                        /* DESIGN LOGIC */
        //                        if(opt.ds)
        //                        {
        //                            return; /* PLEASE DON'T REMVOE! */
        //                        }
        //                        loader.sourceComponent = componentTab2;
        //                    }
        //                }
        //                CPButton
        //                {
        //                    sourceWidth: parent.width / 4
        //                    sourceHeight: parent.height
        //                    btnName: "메뉴3"
        //                    rectColor: R.color_buttonColor001
        //                    textColor: "white"
        //                    onClicked:
        //                    {
        //                        /* DESIGN LOGIC */
        //                        if(opt.ds)
        //                        {
        //                            return; /* PLEASE DON'T REMVOE! */
        //                        }
        //                        loader.sourceComponent = componentTab3;
        //                    }
        //                }
        //                CPButton
        //                {
        //                    sourceWidth: parent.width / 4
        //                    sourceHeight: parent.height
        //                    btnName: "메뉴4"
        //                    rectColor: R.color_buttonColor001
        //                    textColor: "white"
        //                    onClicked:
        //                    {
        //                        /* DESIGN LOGIC */
        //                        if(opt.ds)
        //                        {
        //                            return; /* PLEASE DON'T REMVOE! */
        //                        }
        //                        loader.sourceComponent = componentTab4;
        //                    }
        //                }
        //            }
        //        }
    }

}

