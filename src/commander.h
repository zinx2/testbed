#ifndef COMMANDER_H
#define COMMANDER_H

#include <QObject>

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


public slots:
    void joinSNS();
    void loginKakao();

    void onLoginSuccess();
    void onLoginFailed();

private:
    Commander(QObject *parent = NULL);
    ~Commander();

    static Commander* m_instance;
};

#endif // COMMANDER_H
