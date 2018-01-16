#include "native_app.h"

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

void NativeApp::notifyLoginResult(bool result)
{
    if(result)
        emit loginSuccess();
    else
        emit loginFailed();
}


/* PC Version */
#if !defined(Q_OS_ANDROID) && !defined(Q_OS_IOS)
QString NativeApp::getDeviceId() const
{
    return "123456789011123";
}
void NativeApp::loginKakao()
{
    qDebug() << "THIS EVENT WAS INVOKED AT PC VERSION. HAS NO EVENT.";
}
#endif

