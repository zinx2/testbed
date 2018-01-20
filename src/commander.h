#ifndef COMMANDER_H
#define COMMANDER_H

#include <QObject>
#include "native_app.h"
class Settings;
class Commander : public QObject
{
    Q_OBJECT
public:
    static Commander* getInstance()
    {
        if (m_instance == nullptr)
            m_instance = new Commander();
        return m_instance;
    }

    enum SNS_TYPE { NONE, EMAIL, KAKAO, FACEBOOK };

public slots:
    void joinSNS();

    void loginKakao();
    void logoutKakao();
    void withdrawKakao();

	void loginFacebook();
	void logoutFacebook();
	void withdrawFacebook();

    void onLoginSuccess(const char* result);
    void onLoginFailed(const char* result);

    void onLogoutSuccess();
    void onLogoutFailed();

    void onTokenGetSuccess(const char* result);
    void onTokenGetFailed(const char* result);

    void onWithdrawSuccess();
    void onWithdrawFailed();


private:
    Commander(QObject *parent = NULL);
    ~Commander();

    NativeApp* app;
    static Commander* m_instance;

    SNS_TYPE m_snsType;
    Settings* m_settings;
};

#endif // COMMANDER_H
