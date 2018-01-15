import QtQuick 2.9
import QtQuick.Controls 2.2
import "Resources.js" as R

Paper {
    titleText: "이메일 회원가입"

    id: mainView
    visibleBackBtn: true
    visibleSearchBtn: false

    Column
    {
        y:R.height_titlaBar

        CPButton
        {
            sourceWidth: parent.width
            sourceHeight: R.height_button_middle
            btnName: "회원가입 완료"
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
                popupStack.pop();
            }
        }
    }

    onEvtBack:
    {
        stackView.pop();
    }
}
