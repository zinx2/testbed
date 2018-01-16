#include "commander.h"
#include <QDebug>
#include "native_app.h"
Commander* Commander::m_instance = nullptr;
Commander::Commander(QObject *parent) : QObject(parent)
{

}
Commander::~Commander()
{
    //delete m_model;
}

void Commander::joinSNS()
{
    qDebug() << "JOIN USING SNS";
}

void Commander::loginKakao()
{
    qDebug() << "LOGIN USING SNS";

    NativeApp* app = NativeApp::getInstance();
    app->loginKakao();

    connect(app, SIGNAL(loginSuccess()), this, SLOT(onLoginSuccess()));
    connect(app, SIGNAL(loginFailed()), this, SLOT(onLoginFailed()));
}

void Commander::onLoginSuccess()
{
    qDebug() << "LOGIN SUCCESS";
}

void Commander::onLoginFailed()
{
    qDebug() << "LOGIN FAILED";
}
