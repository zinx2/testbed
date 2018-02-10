#include <QAndroidJniEnvironment>
#include <QAndroidJniObject>
#include <QtAndroid>
#include <QDebug>
#include <QDir>
#include "../src/native_app.h"

QString NativeApp::getDeviceId()
{
    QAndroidJniObject activity = QtAndroid::androidActivity();
    QAndroidJniObject result = activity.callObjectMethod<jstring>("getDeviceId");

    QAndroidJniEnvironment env;
    if (env->ExceptionCheck())
    {
        env->ExceptionDescribe();
        env->ExceptionClear();
        qCritical("Something Was Wrong!!");
        return "";
    }
    return result.toString();
}

QString NativeApp::getAppVersion()
{
    QAndroidJniObject activity = QtAndroid::androidActivity();
    QAndroidJniObject result = activity.callObjectMethod<jstring>("getAppVersion");

    QAndroidJniEnvironment env;
    if (env->ExceptionCheck())
    {
        env->ExceptionDescribe();
        env->ExceptionClear();
        qCritical("Something Was Wrong!!");
        return "";
    }
    return result.toString();
}
QString NativeApp::getPhoneNumber()
{
    QAndroidJniObject activity = QtAndroid::androidActivity();
    QAndroidJniObject result = activity.callObjectMethod<jstring>("getPhoneNumber");

    QAndroidJniEnvironment env;
    if (env->ExceptionCheck())
    {
        env->ExceptionDescribe();
        env->ExceptionClear();
        qCritical("Something Was Wrong!!");
        return "";
    }
    return result.toString();
}

void NativeApp::invitePerson(QString senderId, QString message, QString url)
{

}

void NativeApp::joinKakao()
{

}

void NativeApp::loginKakao()
{
    QAndroidJniObject activity = QtAndroid::androidActivity();
    activity.callMethod<void>("loginKakao", "()V");

    QAndroidJniEnvironment env;
    if (env->ExceptionCheck())
    {
      env->ExceptionDescribe();
      env->ExceptionClear();
    }
}

void NativeApp::logoutKakao()
{
    QAndroidJniObject activity = QtAndroid::androidActivity();
    activity.callMethod<void>("logoutKakao", "()V");

    QAndroidJniEnvironment env;
    if (env->ExceptionCheck())
    {
      env->ExceptionDescribe();
      env->ExceptionClear();
    }
}

void NativeApp::withdrawKakao()
{
    QAndroidJniObject activity = QtAndroid::androidActivity();
    activity.callMethod<void>("withdrawKakao", "()V");

    QAndroidJniEnvironment env;
    if (env->ExceptionCheck())
    {
      env->ExceptionDescribe();
      env->ExceptionClear();
    }
}

void NativeApp::inviteKakao(QString senderId, QString image, QString title, QString desc, QString link)
{
    QAndroidJniObject idStr = QAndroidJniObject::fromString(senderId);
    QAndroidJniObject imageStr = QAndroidJniObject::fromString(image);
    QAndroidJniObject titleStr = QAndroidJniObject::fromString(title);
    QAndroidJniObject descStr = QAndroidJniObject::fromString(desc);
    QAndroidJniObject linkStr = QAndroidJniObject::fromString(link);

    QAndroidJniObject activity = QtAndroid::androidActivity();
    activity.callMethod<void>("inviteKakao", "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V",
                              idStr.object<jstring>(), imageStr.object<jstring>(), titleStr.object<jstring>(), descStr.object<jstring>(), linkStr.object<jstring>());

    QAndroidJniEnvironment env;
    if (env->ExceptionCheck())
    {
      env->ExceptionDescribe();
      env->ExceptionClear();
    }
}

void NativeApp::loginFacebook()
{
    QAndroidJniObject activity = QtAndroid::androidActivity();
    activity.callMethod<void>("loginFacebook", "()V");

    QAndroidJniEnvironment env;
    if (env->ExceptionCheck())
    {
      env->ExceptionDescribe();
      env->ExceptionClear();
    }
}

void NativeApp::logoutFacebook()
{
    QAndroidJniObject activity = QtAndroid::androidActivity();
    activity.callMethod<void>("logoutFacebook", "()V");

    QAndroidJniEnvironment env;
    if (env->ExceptionCheck())
    {
      env->ExceptionDescribe();
      env->ExceptionClear();
    }
}

void NativeApp::withdrawFacebook()
{
    QAndroidJniObject activity = QtAndroid::androidActivity();
    activity.callMethod<void>("withdrawFacebook", "()V");

    QAndroidJniEnvironment env;
    if (env->ExceptionCheck())
    {
      env->ExceptionDescribe();
      env->ExceptionClear();
    }
}

void NativeApp::inviteFacebook(QString senderId, QString image, QString title, QString desc, QString link)
{
    QAndroidJniObject idStr = QAndroidJniObject::fromString(senderId);
    QAndroidJniObject imageStr = QAndroidJniObject::fromString(image);
    QAndroidJniObject titleStr = QAndroidJniObject::fromString(title);
    QAndroidJniObject descStr = QAndroidJniObject::fromString(desc);
    QAndroidJniObject linkStr = QAndroidJniObject::fromString(link);

    QAndroidJniObject activity = QtAndroid::androidActivity();
    activity.callMethod<void>("showEmail", "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V",
                              idStr.object<jstring>(), imageStr.object<jstring>(), titleStr.object<jstring>(), descStr.object<jstring>(), linkStr.object<jstring>());

    QAndroidJniEnvironment env;
    if (env->ExceptionCheck())
    {
      env->ExceptionDescribe();
      env->ExceptionClear();
    }
}

