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
            btnName: "카카오톡 로그인"
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
                cmd.loginSNS();
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
    }

}
