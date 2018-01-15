#pragma once
#include <QObject>
#include <QList>
#include <QDebug>

using namespace std;

class Concept : public QObject {
	Q_OBJECT
		Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
		Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
        Q_PROPERTY(QString src READ src WRITE setSrc NOTIFY srcChanged)
		Q_PROPERTY(bool visibled READ visibled WRITE setVisibled NOTIFY visibledChanged)

public:
	Concept(QObject* parent = 0) : QObject(parent) { }
    Concept(int id, QString name, QString src) : m_id(id), m_name(name), m_src(src) { }

	Q_INVOKABLE int id() const { return m_id; }    
	Q_INVOKABLE QString name() const { return m_name; }
    Q_INVOKABLE QString src() const { return m_src; }
    Q_INVOKABLE bool visibled() const { return m_visibled; }

	public slots:
	void setId(const int id) { m_id = id; }    
	void setName(const QString &m) { m_name = m; emit nameChanged(); }
    void setSrc(const QString &m) { m_src = m; emit srcChanged(); }
    void setVisibled(const bool &m) { m_visibled = m; emit visibledChanged(); }

signals:
	void idChanged();
	void nameChanged();
    void srcChanged();
    void visibledChanged();

private:
	int m_id = -1;
	QString m_name;
    QString m_src;
    bool m_visibled = true;

};
//Q_DECLARE_METATYPE(Concept*)



class Model : public QObject
{
	Q_OBJECT
        Q_PROPERTY(int currentIndex READ currentIndex WRITE setCurrentIndex NOTIFY currentIndexChanged)
        Q_PROPERTY(QList<QObject*> list READ list NOTIFY listChanged)
		Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
		Q_PROPERTY(QString error READ error WRITE setError NOTIFY errorChanged)
public:
	static Model* getInstance() {
		if (m_instance == nullptr)
			m_instance = new Model();
		return m_instance;
	}

    Q_INVOKABLE int currentIndex() const { return m_currentIndex; }
    Q_INVOKABLE int size() const { return m_list.length(); }
    Q_INVOKABLE QString getName(int index) { return qobject_cast<Concept*>(m_list[index])->name(); }
    Q_INVOKABLE QString getSrc(int index) { return qobject_cast<Concept*>(m_list[index])->src(); }
    Q_INVOKABLE QList<QObject*> list() const { return m_list; }
    Q_INVOKABLE QObject* getCurrentConcept() { return m_list[m_currentIndex]; }
	Q_INVOKABLE QString title() const { return m_title; }
	Q_INVOKABLE QString error() const { return m_error; }

public slots:
	void setTitle(const QString m) { m_title = m; emit titleChanged(); }
    void setCurrentIndex(const int id) { m_currentIndex = id; emit currentIndexChanged(); }
    void initializeIndex() { m_currentIndex = -1; }
    void initialize()
    {
        for(QObject* obj : m_list)
        {
            Concept* cb = qobject_cast<Concept*>(obj);
            cb->setVisibled(true);
        }

        emit listChanged();
    }
    void search(QString str)
    {

        for(QObject* obj : m_list)
        {
            Concept* cb = qobject_cast<Concept*>(obj);
            cb->setVisibled(cb->name().contains(str));
            qDebug() << cb->name();
            qDebug() << str;
            qDebug() << cb->name().contains(str);
        }
        emit listChanged();
    }
	void setError(const QString m) { m_error = m; emit errorChanged(); }

signals:
    void listChanged();
    void currentIndexChanged();
	void titleChanged();
	void errorChanged();

private:
	static Model* m_instance;
	Model()	{ }

    QList<QObject*> m_list;
    int m_currentIndex = 0;
	QString m_title = "TITLE";
	QString m_error = "ERROR";
};
