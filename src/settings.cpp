#include "settings.h"

Settings* Settings::m_instance = nullptr;
Settings::Settings(QObject *parent) : QObject(parent)
{

}
Settings::~Settings()
{

}
