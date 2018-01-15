#pragma once
#include <QObject>

class NativeApp : public QObject
{
    Q_OBJECT
public:
	QString deviceId();

	void resume();
	void pause();

    public slots:
    QString getDeviceId() const;

signals:
	void resumed();
	void paused();


private:
	QString m_deviceId;
};
extern NativeApp* native;
