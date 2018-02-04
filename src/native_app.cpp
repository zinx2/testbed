#include "native_app.h"
#include <QDebug>
NativeApp* NativeApp::m_instance = nullptr;
NativeApp::NativeApp(QObject *parent) : QObject(parent)
{

}
NativeApp::~NativeApp()
{

}

QString NativeApp::deviceId() {
	if (m_deviceId.length() == 0)
		m_deviceId = getDeviceId();
	return m_deviceId;
}

void NativeApp::resume()
{

}
void NativeApp::pause()
{

}

void NativeApp::notifyLoginResult(bool isSuccess, const char* result)
{
    if(isSuccess)
        emit loginSuccess(result);
    else
        emit loginFailed(result);
}

void NativeApp::notifyLogoutResult(bool isSuccess)
{
    if(isSuccess)
        emit logoutSuccess();
    else
        emit logoutFailed();
}

void NativeApp::notifyWithdrawResult(bool isSuccess)
{
    if(isSuccess)
        emit withdrawSuccess();
    else
        emit withdrawFailed();
}

void NativeApp::notifyTokenInfo(bool isSuccess, const char* result)
{
    if(isSuccess)
        emit tokenInfoSuccess(result);
    else
        emit tokenInfoFailed(result);
}


/* PC Version */
#if !defined(Q_OS_ANDROID) && !defined(Q_OS_IOS)
QString NativeApp::getDeviceId() const
{
    return "123456789011123";
}
void NativeApp::joinKakao()
{
    qDebug() << "THIS EVENT WAS INVOKED AT PC VERSION. HAS NO EVENT.";
}
void NativeApp::loginKakao()
{
    qDebug() << "THIS EVENT WAS INVOKED AT PC VERSION. HAS NO EVENT.";
}
void NativeApp::logoutKakao()
{
    qDebug() << "THIS EVENT WAS INVOKED AT PC VERSION. HAS NO EVENT.";
}
void NativeApp::withdrawKakao()
{
    qDebug() << "THIS EVENT WAS INVOKED AT PC VERSION. HAS NO EVENT.";
}
void NativeApp::loginFacebook()
{
	qDebug() << "THIS EVENT WAS INVOKED AT PC VERSION. HAS NO EVENT.";
}
void NativeApp::logoutFacebook()
{
	qDebug() << "THIS EVENT WAS INVOKED AT PC VERSION. HAS NO EVENT.";
}
void NativeApp::withdrawFacebook()
{
	qDebug() << "THIS EVENT WAS INVOKED AT PC VERSION. HAS NO EVENT.";
}
#endif

