import QtQuick 2.9
import QtQuick.Controls 2.2
import "Resources.js" as R

Rectangle {

    property bool logined : opt.ds ? false : settings.logined


    Column
    {
        width: parent.width
        height: parent.height
        spacing: R.dp(10)
        CPButton
        {
            sourceWidth: parent.width
            sourceHeight: R.height_button_middle
            btnName: "이메일 로그인"
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
                userStackView.push(Qt.createComponent(R.view_file_loginEmail), { });
            }
        }

        CPButton
        {
            sourceWidth: parent.width
            sourceHeight: R.height_button_middle
            btnName: "카카오 로그인"
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
                cmd.loginKakao();
            }
        }

        CPButton
        {
            sourceWidth: parent.width
            sourceHeight: R.height_button_middle
            btnName: "페이스북 로그인"
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
                cmd.loginFacebook();
            }
        }



        CPButton
        {
            sourceWidth: parent.width
            sourceHeight: R.height_button_middle
            btnName: "회원가입 하기"
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
                userStackView.push(Qt.createComponent(R.view_file_joinDesk), { });
            }
        }

        /* 테스트용 */
        CPButton
        {
            sourceWidth: parent.width
            sourceHeight: R.height_button_middle
            btnName: "메인으로 바로 가기"
            rectColor: R.color_buttonColor001
            textColor: "white"
            onClicked:
            {
                settings.setLogined(true);
            }
        }

        /* 테스트용 */
        CPButton
        {
            sourceWidth: parent.width
            sourceHeight: R.height_button_middle
            btnName: "초기화"
            rectColor: R.color_buttonColor001
            textColor: "white"
            onClicked:
            {
                settings.setLogined(false);
                settings.setNickName("");
                settings.setEmail("");
                settings.setThumbnailImage("");
                settings.setProfileImage("");
            }
        }

        CPText
        {
            id: lb_nickName
            font.pointSize: R.pt(18)
            text: "NICKNAME : " + settings.nickName
        }

        CPText
        {
            id: lb_email
            font.pointSize: R.pt(18)
            text: "EMAIL : " + settings.email
        }

        CPText
        {
            id: lb_thumbnail
            font.pointSize: R.pt(18)
            text: "THUMBNAIL IMAGE : " + settings.thumbnailImage
        }

        CPText
        {
            id: lb_profile
            font.pointSize: R.pt(18)
            text: "PROFILE IMAGE : " + settings.profileImage
        }
    }
}
