#include "commander.h"
#include "settings.h"
#include <QDebug>
#include <QJsonDocument>
#include <QJsonObject>

Commander* Commander::m_instance = nullptr;
Commander::Commander(QObject *parent) : QObject(parent)
{
    app = NativeApp::getInstance();
    connect(app, SIGNAL(loginSuccess(const char*)), this, SLOT(onLoginSuccess(const char*)));
    connect(app, SIGNAL(loginFailed(const char*)), this, SLOT(onLoginFailed(const char*)));
    connect(app, SIGNAL(logoutSuccess()), this, SLOT(onLogoutSuccess()));
    connect(app, SIGNAL(logoutFailed()), this, SLOT(onLogoutFailed()));
    connect(app, SIGNAL(withdrawSuccess()), this, SLOT(onWithdrawSuccess()));
    connect(app, SIGNAL(withdrawFailed()), this, SLOT(onWithdrawFailed()));

    m_settings = Settings::getInstance();
//    connect(app, SIGNAL(tokenInfoSuccess(QString)), this, SLOT(onTokenGetSuccess(QString)));
//    connect(app, SIGNAL(tokenInfoFailed(QString)), this, SLOT(onTokenGetFailed(QString)));
}
Commander::~Commander()
{
    //delete m_model;
}

void Commander::joinSNS()
{
    qDebug() << "JOIN USING SNS";
}

void Commander::joinKakao()
{
    qDebug() << "JOIN USING SNS";
    app->joinKakao();
}

void Commander::loginKakao()
{
    qDebug() << "LOGIN USING SNS";    
    m_settings->setSnsType(SNS_TYPE::KAKAO);
    app->loginKakao();
}

void Commander::logoutKakao()
{
    qDebug() << "LOGOUT USING SNS";
    app->logoutKakao();
}

void Commander::withdrawKakao()
{
    qDebug() << "WITHDRAW USING SNS";
    app->withdrawKakao();
}

void Commander::loginFacebook()
{
	qDebug() << "LOGIN USING SNS";
	m_settings->setSnsType(SNS_TYPE::FACEBOOK);
	app->loginFacebook();
}
void Commander::logoutFacebook()
{
	qDebug() << "LOGOUT USING SNS";
	app->logoutFacebook();
}
void Commander::withdrawFacebook()
{
    qDebug() << "WITHDRAW FACEBOOK ACCOUNT";
    app->withdrawFacebook();
}

void Commander::onLoginSuccess(const char* result)
{
	qDebug() << "Commander::onLoginSuccess >> ";
    qDebug() << result;

    QString qresult(result);
    QJsonDocument jsonDoc = QJsonDocument::fromJson(qresult.toLocal8Bit());
	QJsonObject jsonObj = jsonDoc.object();

    bool isLogined = jsonObj["is_logined"].toBool();
    m_settings->setLogined(isLogined);
    if(!isLogined)
    {
        m_settings->setNickName(jsonObj["nickname"].toString());
        m_settings->setEmail(jsonObj["email"].toString());
        m_settings->setThumbnailImage(jsonObj["thumbnail_image"].toString());
        m_settings->setProfileImage(jsonObj["profile_image"].toString());
    }
}

void Commander::onLoginFailed(const char* result)
{
    qDebug() << "LOGIN FAILED";
    qDebug() << result;

    m_settings->setLogined(false);
    m_settings->setSnsType(SNS_TYPE::NONE);
    m_settings->setNickName("");
    m_settings->setEmail("");
    m_settings->setThumbnailImage("");
    m_settings->setProfileImage("");

    QString qresult(result);
    QJsonDocument jsonDoc = QJsonDocument::fromJson(qresult.toLocal8Bit());
    QJsonObject jsonObj = jsonDoc.object();

    m_settings->setErrorMessage(jsonObj["error_message"].toString());
}

void Commander::onLogoutSuccess()
{
    qDebug() << "LOGOUT SUCCESS";    
    m_settings->setLogined(false);
    m_settings->setSnsType(SNS_TYPE::NONE);
    m_settings->setNickName("");
    m_settings->setEmail("");
    m_settings->setThumbnailImage("");
    m_settings->setProfileImage("");
}

void Commander::onLogoutFailed()
{
    qDebug() << "LOGOUT FAILED";
}

void Commander::onTokenGetSuccess(const char* result)
{
    qDebug() << "TOKEN GET SUCCESS";
}

void Commander::onTokenGetFailed(const char* result)
{
    qDebug() << "TOKEN GET FAILED";
}

void Commander::onWithdrawSuccess()
{
    qDebug() << "WITHDRAW SUCCESS";
    m_settings->setLogined(false);
    m_settings->setSnsType(SNS_TYPE::NONE);    
    m_settings->setNickName("");
    m_settings->setEmail("");
    m_settings->setThumbnailImage("");
    m_settings->setProfileImage("");
}

void Commander::onWithdrawFailed()
{
    qDebug() << "WITHDRAW FAILED";
}
