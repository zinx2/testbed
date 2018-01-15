function dp(size) { return di.dp(size); }
function pt(size) { return di.pt(size); }

function log() { di.log(); }
function image(name) { return "../img/" + name; }
function font(name) { return "../font/" + name }
function qml() { return "../qml/" + name }
function os() { return Qt.platform.os; }

var height_titlaBar = dp(144);
var height_button_middle = dp(144);

var color_appTitlebar = "#272e36"
var color_appTitleText = "#ffffff"
var color_buttonPressed = "#44000000"
var color_bgColor001 = "#e4e5e9"
var color_buttonColor001 = "#272e36"
var color_orange = "#f6712a"
var color_toast = "#656565"

var color_kut_orange = "#ff7f00"
var color_kut_blue = "#183072"
var color_kut_lightBlue = "#22449c"
var color_kut_lightGray = "#b3b3aa"
var color_kut_gray = "#4c4c4c"

var MARGIN_XL     =   pt(45)//80
var MARGIN_L      =  pt(37.5)//72
var MARGIN_ML     = pt(33.5)//64
var MARGIN_M      = pt(21)//40
var MARGIN_MS      = pt(17)//32
var MARGIN_S       =  pt(12.5)//24
var MARGIN_XS       = pt(8)//16
var MARGIN_XXS       = pt(5)//8

var font_XXXXL        =  pt(89.25)//170
var font_XXXL        =  pt(51)//98
var font_XXL        = pt(38.5)//74
var font_XL         =  pt(35)//67
var font_L         =pt(30)//57
var font_ML        = pt(24.5)//47
var font_M           = pt(21.5)//41
var font_S         =  pt(19)//36
var font_XS         =  pt(17)//32.5


var string_title  = "OLEI Testbed"


var design_size_width = di.width();
var design_size_height = di.height();

var view_file_popup = "CPPopup.qml"

var view_file_home = "VWHome.qml"
var view_file_joinDesk = "VWJoinDesk.qml"
var view_file_joinEmail = "VWJoinEmail.qml"
var view_file_loginEmail = "VWLoginEmail.qml"
var view_file_desc = "VWDesc.qml"

