#include "commander.h"
#include <QDebug>
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

void Commander::loginSNS()
{
    qDebug() << "LOGIN USING SNS";
}
