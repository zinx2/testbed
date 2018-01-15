#include <QAndroidJniEnvironment>
#include <QAndroidJniObject>
#include <QtAndroid>
#include <QDebug>
#include <QDir>
#include "../src/native_app.h"

QString NativeApp::getDeviceId() const
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
