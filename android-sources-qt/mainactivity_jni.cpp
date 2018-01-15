#include "mainactivity_jni.h"
#include "../src/native_app.h"


void Java_ac_olei_testbed_MainActivity_resume(JNIEnv *env, jobject obj)
{
  Q_UNUSED(env)
  Q_UNUSED(obj)

  if(native){
    NativeApp* app = native;
    app->resume();
  }
}

void Java_ac_olei_testbed_MainActivity_pause(JNIEnv *env, jobject obj)
{
    Q_UNUSED(env)
    Q_UNUSED(obj)

    if(native){
      NativeApp* app = native;
      app->pause();
    }
}


//void Java_org_koreatech_trizcartoon_MainActivity_backPressed(JNIEnv *env, jobject obj)
//{
//  Q_UNUSED(env)
//  Q_UNUSED(obj)

//  if(native){
//    NativeApp* app = native;
//    app->backPressed();
//  }
//}

//void Java_org_koreatech_trizcartoon_MainActivity_updateUser(JNIEnv *env, jobject obj,
//                                                                    jstring media, jstring userKey, jstring userName, jstring userProfileImage )
//{
//    Q_UNUSED(env)
//    Q_UNUSED(obj)

//    //int newAmount = (int) value;
//    //int oldMoney = MainAppInterface::instance()->facebookHashKey();
//    //MainAppInterface::instance()->setFacebookHashKey(oldMoney + newAmount);
//    const char * mediaChar = env->GetStringUTFChars(media, NULL);
//    const char * userKeyChar = env->GetStringUTFChars(userKey, NULL);
//    const char * userNameChar = env->GetStringUTFChars(userName, NULL);
//    const char * userProfileImageChar = env->GetStringUTFChars(userProfileImage, NULL);

//    NativeApp* app = native;
//    app->setUserData(QString(mediaChar == NULL ? "": mediaChar),
//                         QString(userKeyChar == NULL ? "": userKeyChar),
//                         QString(userNameChar == NULL ? "": userNameChar),
//                         QString(userProfileImageChar == NULL ? "": userProfileImageChar));
//}

//void Java_org_koreatech_trizcartoon_MainActivity_loginMediaFinished(JNIEnv *env, jobject obj,
//                                                                        jboolean isSuccess)
//{
//    Q_UNUSED(env)
//    Q_UNUSED(obj)

//    //int newAmount = (int) value;
//    //int oldMoney = MainAppInterface::instance()->facebookHashKey();
//    //MainAppInterface::instance()->setFacebookHashKey(oldMoney + newAmount);
//    MainAppInterface* mainApp = app;
//    mainApp->setLoginMediaFinished(isSuccess);
//}


//void Java_org_koreatech_trizcartoon_MainActivity_logoutMediaFinished(JNIEnv *env, jobject obj,
//                                                                        jboolean isSuccess)
//{
//    Q_UNUSED(env)
//    Q_UNUSED(obj)

//    //int newAmount = (int) value;
//    //int oldMoney = MainAppInterface::instance()->facebookHashKey();
//    //MainAppInterface::instance()->setFacebookHashKey(oldMoney + newAmount);
//    MainAppInterface* mainApp = app;
//    mainApp->setLogoutMediaFinished(isSuccess);
//}

//void Java_org_koreatech_trizcartoon_MainActivity_gcmReceivedNotice(JNIEnv *env, jobject obj, jint type, jstring msg)
//{
//  Q_UNUSED(env)
//  Q_UNUSED(obj)

//  const char * msgChar = env->GetStringUTFChars(msg, NULL);
//  MainAppInterface* mainApp = app;
//  mainApp->gcmReceivedNotice((int)type, QString(msgChar == NULL ? "": msgChar));
//}

//void  Java_org_koreatech_trizcartoon_MainActivity_openUrlFinished(JNIEnv *env, jobject obj, jboolean isSuccess)
//{
//	Q_UNUSED(env)
//	Q_UNUSED(obj)

//	MainAppInterface* mainApp = app;
//	mainApp->setOpenUrlFinished(isSuccess);
//}
