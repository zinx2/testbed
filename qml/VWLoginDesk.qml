import QtQuick 2.9
import QtQuick.Controls 2.2
import "Resources.js" as R

Rectangle {

    width: opt.ds ? R.design_size_width : parent.width
    height: opt.ds ? R.design_size_height : parent.height

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
            rectColor: R.color_kut_lightBlue
            textColor: "white"
            onClicked:
            {
                /* DESIGN LOGIC */
                if(opt.ds)
                {



                    return; /* PLEASE DON'T REMVOE! */
                }

                /* NOT DESIGN LOGIC */
                stackView.push(Qt.createComponent(R.view_file_loginEmail), { });
            }
        }

        CPButton
        {
            sourceWidth: parent.width
            sourceHeight: R.height_button_middle
            btnName: "카카오 로그인"
            rectColor: R.color_kut_lightBlue
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
            btnName: "카카오 로그아웃"
            rectColor: R.color_kut_lightBlue
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
            rectColor: R.color_kut_lightBlue
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
            btnName: "페이스북 로그인"
            rectColor: R.color_kut_lightBlue
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
            btnName: "페이스북 로그아웃"
            rectColor: R.color_kut_lightBlue
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
            rectColor: R.color_kut_lightBlue
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

        CPButton
        {
            sourceWidth: parent.width
            sourceHeight: R.height_button_middle
            btnName: "회원가입 하기"
            rectColor: R.color_kut_lightBlue
            textColor: "white"
            onClicked:
            {
                /* DESIGN LOGIC */
                if(opt.ds)
                {



                    return; /* PLEASE DON'T REMVOE! */
                }

                /* NOT DESIGN LOGIC */
                stackView.push(Qt.createComponent(R.view_file_joinDesk), { });
            }
        }

        CPText
        {
            id: lb_snsType
            font.pointSize: R.pt(18)
            text: {
                var type = settings.snsType;
                switch(type)
                {
                case 0: return "로그인되지 않음";
                case 1: return "이메일로 로그인";
                case 2: return "카카오로 로그인";
                case 3: return "페이스북으로 로그인"
                }
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
