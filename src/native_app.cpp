#include "native_app.h"

NativeApp* native;
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

#if !defined(Q_OS_ANDROID) && !defined(Q_OS_IOS)
QString NativeApp::getDeviceId() const
{
    return "123456789011123";
}
#endif

