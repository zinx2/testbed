import QtQuick 2.0
import "Resources.js" as R
Column
{
//    width: R.design_size_width
//    height: R.design_size_height
    property int txtFontSize: R.pt(18)
    property int rightMargin: R.dp(120)
    property int leftMargin : R.dp(20)
    CPSubtitle
    {
        id: subtitle
        anchors { left: parent.left; leftMargin: R.dp(20); }
        title : "모순행렬이란?"
    }
    LYMargin { height: R.dp(20) }
    CPDescText
    {
        fontSize: txtFontSize
        paddingRight: R.dp(rightMargin)
        desc: "기술적 모순을 해결하는데 가장 효과적인 발명 원리를 " + "<font color='"+ R.color_orange + "'>39X39</font>의 2차원 행렬로 표현"        
    }

    LYMargin { height: R.dp(30) }
    CPDescText
    {
        fontSize: txtFontSize
        paddingRight: R.dp(rightMargin)
        desc: "모순 행렬에서는 " + "<font color='"+ R.color_orange + "'>세로 측에는 개선되는 특성</font>을, "
              +"<font color='" + R.color_orange + "'>가로측에는 악화되는 특성을</font> 찾은 다음, 이 두가지 특성이 교차하는 위치에서 두 가지 특성 간의 기술적 "
              +"모순을 해결하는데 가장 많이 사용된 3~4개의 발명 원리를 확인"
    }

    LYMargin { height: R.dp(30) }
    CPDescText
    {
        fontSize: txtFontSize
        paddingRight: R.dp(rightMargin)
        desc: "나열된 발명 원리의 순서는 활용 빈도를 표현함"
    }
}
