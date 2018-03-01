import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "Resources.js" as R

Paper {
    id: mainView
    visibleBackBtn: false
    visibleSearchBtn: false

//    property bool logouted : opt.ds ? false : !settings.logined
//    onLogoutedChanged: {
//        if(logouted) {
//            stackView.clear();
//            stackView.push(Qt.createComponent(R.view_file_loginDesk), { });
//        }
//    }

    ScrollView
    {
        id: scrollView
        clip: true
        width: parent.width
        height: parent.height - R.height_titlaBar - 1
        y: R.height_titlaBar + 1

        Column
        {
            width: scrollView.width
            height: scrollView.height
            spacing: 1
            CPButton
            {
                sourceWidth: parent.width
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

            CPButton
            {
                sourceWidth: parent.width
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

            CPButton
            {
                sourceWidth: parent.width
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

            CPButton
            {
                sourceWidth: parent.width
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

//            CPImage { source: "image://async/img001.jpg"; height : R.dp(500); width: parent.width}7
            CPText
            {
                text: md.error
                font.pointSize: R.pt(22)
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
            }

            CPButton
            {
                sourceWidth: parent.width
                sourceHeight: R.dp(100)
                width: parent.width
                height: R.dp(100)
                type: "text"
                btnName: "GET ALL DEMO LIST~"
                rectColor: "orange"
                textColor: "white"
                fontSize: R.pt(15)
                onClicked: {
                    wk.getDemoAll();
                }
            }


            CPButton
            {
                sourceWidth: parent.width
                sourceHeight: R.dp(100)
                width: parent.width
                height: R.dp(100)
                type: "text"
                btnName: "GET A DEMO."
                rectColor: "orange"
                textColor: "white"
                fontSize: R.pt(15)
                onClicked:
                {
                    wk.getDemo(15);
                }
            }

            CPButton
            {
                sourceWidth: parent.width
                sourceHeight: R.dp(100)
                width: parent.width
                height: R.dp(100)
                type: "text"
                btnName: "POST ALL DEMO LIST~"
                rectColor: "orange"
                textColor: "white"
                fontSize: R.pt(15)
                onClicked: {
                    wk.postDemoAll();
                }
            }

            CPButton
            {
                sourceWidth: parent.width
                sourceHeight: R.dp(100)
                width: parent.width
                height: R.dp(100)
                type: "text"
                btnName: "POST A DEMO ~"
                rectColor: "orange"
                textColor: "white"
                fontSize: R.pt(15)
                onClicked: {
                    wk.postDemo(11);
                }
            }
        }
    }




}

