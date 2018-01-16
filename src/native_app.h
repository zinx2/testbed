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
    void loginKakao();

    void notifyLoginResult(bool result);

    public slots:
    QString getDeviceId() const;

signals:
	void resumed();
	void paused();
    void loginSuccess();
    void loginFailed();

private:
    static NativeApp* m_instance;
    NativeApp(QObject *parent = NULL);
    ~NativeApp();

private:
	QString m_deviceId;
};
