#include "imagebinaryloader.h"
#include <QDebug>
#include <QWaitCondition>

ImageBinaryLoader::ImageBinaryLoader(QObject *parent) : QObject(parent)
{

}

void ImageBinaryLoader::requestImage(QString urlStr, QMutex* mtx)
{
	m_mtx = mtx;
	QUrl url(DOMAIN_NAME + "img/" + urlStr);
	QNetworkRequest request(url);

	m_netReply = m_netManager.get(request);
	//connect(&m_netManager, &QNetworkAccessManager::finished, this, &NetWorker::loadImage);
	connect(m_netReply, &QNetworkReply::finished, this,
		[&]()-> void {
		m_binary = m_netReply->readAll();
		m_mtx->unlock();
		QWaitCondition cond;
		cond.wakeAll();
		//qDebug() << m_binary;

		m_netReply->deleteLater();
	});
	connect(m_netReply, QOverload<QNetworkReply::NetworkError>::of(&QNetworkReply::error), this, QOverload<QNetworkReply::NetworkError>::of(&ImageBinaryLoader::httpError));
}

void ImageBinaryLoader::httpError(QNetworkReply::NetworkError msg)
{
	qDebug() << "[**] THE ERROR WAS OCCURED. " << msg;
	m_notFound = true;
	m_mtx->unlock();
}