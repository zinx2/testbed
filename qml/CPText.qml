import QtQuick 2.0
import "Resources.js" as R

Text {
    wrapMode: Text.Wrap
//    font.pixelSize: R.font_M
    font.family: fontNanumBarunGothic.name
    horizontalAlignment: Text.AlignLeft
//    lineHeight: lineCount==1? 1 :


    //    font.family: fontType==0 ?

    FontLoader {
        id: fontNanumBarunGothic        
        source: R.os() === "android" ? R.font("NanumBarunGothic_android.ttf") : R.font("NanumBarunGothic_ios.ttf")
    }
}
