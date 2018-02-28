import QtQuick 2.9
import QtQuick.Controls 2.2
import "Resources.js" as R

Drawer {
    id: drawer
    interactive : true
    dragMargin : R.dp(20)

    Rectangle{
        width: parent.width
        height: parent.height
        Column{
            spacing: 1
            width: parent.width
            height: parent.height
            CPButton
            {
                sourceWidth: parent.width
                sourceHeight: R.height_button_middle
                btnName: "기능1"
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
//                        cmd.withdrawKakao();
                }
            }
            CPButton
            {
                sourceWidth: parent.width
                sourceHeight: R.height_button_middle
                btnName: "기능1"
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
//                        cmd.withdrawKakao();
                }
            }
            CPButton
            {
                sourceWidth: parent.width
                sourceHeight: R.height_button_middle
                btnName: "기능2"
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
//                        cmd.withdrawKakao();
                }
            }            CPButton
            {
                sourceWidth: parent.width
                sourceHeight: R.height_button_middle
                btnName: "기능3"
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
//                        cmd.withdrawKakao();
                }
            }            CPButton
            {
                sourceWidth: parent.width
                sourceHeight: R.height_button_middle
                btnName: "기능4"
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
//                        cmd.withdrawKakao();
                }
            }            CPButton
            {
                sourceWidth: parent.width
                sourceHeight: R.height_button_middle
                btnName: "기능5"
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
//                        cmd.withdrawKakao();
                }
            }
        }
    }

}
