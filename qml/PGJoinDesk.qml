import QtQuick 2.9
import QtQuick.Controls 2.2
import "Resources.js" as R

Paper {

    id: mainView
    visibleBackBtn: true
    visibleSearchBtn: false

    Column
    {
        y: R.height_titlaBar
        width: parent.width
        height: parent.height
        spacing: R.dp(10)
        CPButton
        {
            sourceWidth: parent.width
            sourceHeight: R.height_button_middle
            btnName: "이메일 회원가입"
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
                userStackView.push(Qt.createComponent(R.view_file_joinEmail), { });
            }
        }

        CPButton
        {
            sourceWidth: parent.width
            sourceHeight: R.height_button_middle
            btnName: "카카오 회원가입"
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
                cmd.joinKakao();
            }
        }

        CPButton
        {
            sourceWidth: parent.width
            sourceHeight: R.height_button_middle
            btnName: "페이스북 회원가입"
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
    }

    onEvtBack:
    {
        userStackView.pop();
    }

}
