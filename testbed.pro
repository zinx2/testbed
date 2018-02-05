QT += quick quickcontrols2 network
CONFIG += c++11
#plugin
#DESTDIR = ImageResponseProviderCore
#TARGET = qmlimageresponseproviderplugin

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

HEADERS += \
    src/display_information.h \
    src/native_app.h \
    src/model.h \
    src/option.h \
    src/networker.h \
    src/imageresponseprovider.h \
    src/imagebinaryloader.h \
    src/commander.h \
    src/settings.h

SOURCES += \
    src/main.cpp \
    src/native_app.cpp \
    src/display_information.cpp \
    src/networker.cpp \
    src/instance_creator.cpp \
    src/imagebinaryloader.cpp \
    src/commander.cpp \
    src/settings.cpp

RESOURCES += qml.qrc \
    img.qrc \
    font.qrc

android {
    QT += androidextras

    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android-sources-native/app

    SOURCES += $$files(android-sources-qt/*.cpp)
    HEADERS += $$files(android-sources-qt/*.h)
}

ios {
    OBJECTIVE_SOURCES += \
        $$files(ios-sources-native/*.h) \
        $$files(ios-sources-native/*.m) \
        $$files(ios-sources-native/*.mm) \

    assets_catalogs.files = $$files($$PWD/ios-sources-native/*.xcassets)\
                            $$PWD/ios-sources-native/SplashLaunchScreen.xib
    QMAKE_BUNDLE_DATA += assets_catalogs
    QMAKE_INFO_PLIST = $$PWD/ios-sources-native/info.plist

    #KAKAOTALK
    LIBS += -F$$PWD/ios-libraries/KakaoSDK \
            -framework KakaoOpenSDK

    #FACEBOOK
    LIBS += -F$$PWD/ios-libraries/FacebookSDK \
            -framework FBSDKCoreKit \
            -framework FBSDKLoginKit \
            -framework Bolts

}

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    img/splash.jpg \
    android-sources-native/app/src/ac/olei/testbed/KaKaoLoginControl.java \
    android-sources-native/app/src/ac/olei/testbed/KakaoSDKAdapter.java \
    android-sources-native/app/src/ac/olei/testbed/KakaoSignupActivity.java

#ANDROID
DISTFILES += $$files(android-sources-native/app/*.*)
DISTFILES += $$files(android-sources-native/app/src/ac/olei/testbed/*.*)
#DISTFILES += $$files(android-sources-native/libs/*.*)
DISTFILES += $$files(android-sources-native/app/res/*.*)
DISTFILES += $$files(android-sources-native/app/res/layout/*.*)
DISTFILES += $$files(android-sources-native/app/res/values/*.*)
DISTFILES += $$files(android-sources-native/app/res/values-ko/*.*)
DISTFILES += $$files(android-sources-native/app/res/drawable/*.*)
DISTFILES += $$files(android-sources-native/app/res/drawable-v24/*.*)
DISTFILES += $$files(android-sources-native/app/res/mipmap-anydpi-v26/*.*)
DISTFILES += $$files(android-sources-native/app/res/mipmap-hdpi/*.*)
DISTFILES += $$files(android-sources-native/app/res/mipmap-mdpi/*.*)
DISTFILES += $$files(android-sources-native/app/res/mipmap-xhdpi/*.*)
DISTFILES += $$files(android-sources-native/app/res/mipmap-xxhdpi/*.*)
DISTFILES += $$files(android-sources-native/app/res/mipmap-xxxhdpi/*.*)

#IOS
DISTFILES += $$files(ios-sources-native/*.*)
DISTFILES += $$files(ios-sources-native/Images.xcassets/*.*)
DISTFILES += $$files(ios-sources-native/Images.xcassets/AppIcon.appiconset/*.*)
DISTFILES += $$files(ios-sources-native/Images.xcassets/LaunchImage.launchimage/*.*)
