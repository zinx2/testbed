#pragma once
#include <QObject>

class NativeApp : public QObject
{
    Q_OBJECT
public:
    static NativeApp* getInstance()
    {
        if (m_instance == nullptr)
            m_instance = new NativeApp();
        return m_instance;
    }

	QString deviceId();

	void resume();
	void pause();

    void joinKakao(); /* connect app */
    void loginKakao();
    void logoutKakao();
    void withdrawKakao();
    void inviteKakao(QString senderId, QString image, QString title, QString desc, QString link);

	void loginFacebook();
	void logoutFacebook();
	void withdrawFacebook();
    void inviteFacebook(QString senderId, QString image, QString title, QString desc, QString link);

    void invitePerson(QString senderId, QString message, QString url);

    QString getDeviceId();
    QString getAppVersion();
    QString getPhoneNumber();

    void notifyLoginResult(bool isSuccess, const char* result);
    void notifyLogoutResult(bool isSuccess);
    void notifyWithdrawResult(bool isSuccess);
    void notifyInviteResult(bool isSuccess);
    void notifyTokenInfo(bool isSuccess, const char* result);




signals:
	void resumed();
	void paused();
    void loginSuccess(const char* result);
    void loginFailed(const char* result);
    void logoutSuccess();
    void logoutFailed();
    void withdrawSuccess();
    void withdrawFailed();
    void inviteSuccess();
    void inviteFailed();
    void tokenInfoSuccess(const char* result);
    void tokenInfoFailed(const char* result);

private:
    static NativeApp* m_instance;
    NativeApp(QObject *parent = NULL);
    ~NativeApp();

private:
	QString m_deviceId;
};
