#pragma once
#include <QSettings>
#include <QObject>

class Settings : public QObject
{
    Q_OBJECT
        Q_PROPERTY(bool logined READ logined WRITE setLogined NOTIFY loginedChanged)
        Q_PROPERTY(int snsType READ snsType WRITE setSnsType NOTIFY snsTypeChanged)
        Q_PROPERTY(QString nickName READ nickName WRITE setNickName NOTIFY nickNameChanged)
        Q_PROPERTY(QString email READ email WRITE setEmail NOTIFY emailChanged)
        Q_PROPERTY(QString thumbnailImage READ thumbnailImage WRITE setThumbnailImage NOTIFY thumbnailImageChanged)
        Q_PROPERTY(QString profileImage READ profileImage WRITE setProfileImage NOTIFY profileImageChanged)
        Q_PROPERTY(QString errorMessage READ errorMessage WRITE setErrorMessage NOTIFY errorMessageChanged)
public:
    static Settings* getInstance()
    {
        if (m_instance == nullptr)
            m_instance = new Settings();
        return m_instance;
    }

    Q_INVOKABLE bool    logined()        const { return valueBool("is_logined"); }
    Q_INVOKABLE int     snsType()        const { return valueInt("sns_type"); }
    Q_INVOKABLE QString nickName()       const { return valueStr("nickname"); }
    Q_INVOKABLE QString email()          const { return valueStr("email"); }
    Q_INVOKABLE QString thumbnailImage() const { return valueStr("thumbnail_image"); }
    Q_INVOKABLE QString profileImage()   const { return valueStr("profile_image"); }
    Q_INVOKABLE QString errorMessage()   const { return valueStr("error_message"); }

    void setValue(QString key, int value) {  m_setting.setValue(key, value); }
    void setValue(QString key, QString value) {  m_setting.setValue(key, value); }
    void setValue(QString key, bool value) { m_setting.setValue(key, value); }

public slots:
    int     valueInt(QString key)  const { return m_setting.value(key).toInt(); }
    QString valueStr(QString key)  const { return m_setting.value(key).toString(); }
    bool    valueBool(QString key) const { return m_setting.value(key).toBool(); }

    void setLogined(const bool &m) { setValue("is_logined", m); emit loginedChanged(); }
    void setSnsType(const int &m) { setValue("sns_type", m); emit snsTypeChanged(); }
    void setNickName(const QString &m) { setValue("nickname", m); emit nickNameChanged(); }
    void setEmail(const QString &m) { setValue("email", m); emit emailChanged(); }
    void setThumbnailImage(const QString &m) { setValue("thumbnail_image", m); emit thumbnailImageChanged(); }
    void setProfileImage(const QString &m) { setValue("profile_image", m); emit profileImageChanged(); }
    void setErrorMessage(const QString &m) { setValue("error_message", m); emit errorMessageChanged(); }

signals:
    void loginedChanged();
    void snsTypeChanged();
    void nickNameChanged();
    void emailChanged();
    void thumbnailImageChanged();
    void profileImageChanged();
    void errorMessageChanged();

private:
    Settings(QObject *parent = NULL);
    ~Settings();

    QSettings m_setting;
    static Settings* m_instance;
};
