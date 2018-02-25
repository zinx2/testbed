/****************************************************************************
 **
 ** Copyright (C) 2016 The Qt Company Ltd.
 ** Contact: https://www.qt.io/licensing/
 **
 ** This file is part of the QtAndroidExtras module of the Qt Toolkit.
 **
 ** $QT_BEGIN_LICENSE:BSD$
 ** Commercial License Usage
 ** Licensees holding valid commercial Qt licenses may use this file in
 ** accordance with the commercial license agreement provided with the
 ** Software or, alternatively, in accordance with the terms contained in
 ** a written agreement between you and The Qt Company. For licensing terms
 ** and conditions see https://www.qt.io/terms-conditions. For further
 ** information use the contact form at https://www.qt.io/contact-us.
 **
 ** BSD License Usage
 ** Alternatively, you may use this file under the terms of the BSD license
 ** as follows:
 **
 ** "Redistribution and use in source and binary forms, with or without
 ** modification, are permitted provided that the following conditions are
 ** met:
 **   * Redistributions of source code must retain the above copyright
 **     notice, this list of conditions and the following disclaimer.
 **   * Redistributions in binary form must reproduce the above copyright
 **     notice, this list of conditions and the following disclaimer in
 **     the documentation and/or other materials provided with the
 **     distribution.
 **   * Neither the name of The Qt Company Ltd nor the names of its
 **     contributors may be used to endorse or promote products derived
 **     from this software without specific prior written permission.
 **
 **
 ** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 ** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 ** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 ** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 ** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 ** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 ** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 ** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 ** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 ** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 ** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
 **
 ** $QT_END_LICENSE$
 **
 ****************************************************************************/

package ac.olei.testbed;

import java.io.IOException;

import android.app.Notification;
import android.app.NotificationManager;

import android.content.SharedPreferences;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;

import android.os.Build;
import android.os.Bundle;
import android.os.AsyncTask;

import android.view.Window;
import android.view.WindowManager;
import android.telephony.TelephonyManager;
import android.util.Log;

import android.widget.LinearLayout;
import android.widget.TextView;

import android.net.Uri;

import com.google.android.gms.ads.identifier.AdvertisingIdClient;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GoogleApiAvailability;
import com.google.android.gms.common.GooglePlayServicesUtil;
import com.google.android.gms.common.GooglePlayServicesNotAvailableException;
import com.google.android.gms.common.GooglePlayServicesRepairableException;
import com.google.android.gms.gcm.GoogleCloudMessaging;

import com.kakao.auth.ApiResponseCallback;
import com.kakao.auth.AuthService;
import com.kakao.auth.ISessionCallback;
import com.kakao.auth.Session;
import com.kakao.auth.network.response.AccessTokenInfoResponse;
import com.kakao.network.ErrorResult;
import com.kakao.usermgmt.UserManagement;
import com.kakao.usermgmt.callback.UnLinkResponseCallback;
import com.kakao.usermgmt.callback.MeResponseCallback;
import com.kakao.usermgmt.callback.LogoutResponseCallback;
import com.kakao.usermgmt.response.model.UserProfile;
import com.kakao.kakaolink.AppActionBuilder;
import com.kakao.kakaolink.AppActionInfoBuilder;
import com.kakao.kakaolink.KakaoLink;
import com.kakao.kakaolink.KakaoTalkLinkMessageBuilder;
import com.kakao.util.exception.KakaoException;
import com.kakao.util.helper.log.Logger;
import com.kakao.util.KakaoParameterException;

import com.facebook.AccessToken;
import com.facebook.CallbackManager;
import com.facebook.FacebookCallback;
import com.facebook.FacebookException;
import com.facebook.FacebookSdk;
import com.facebook.GraphRequest;
import com.facebook.GraphResponse;
import com.facebook.HttpMethod;
import com.facebook.appevents.AppEventsLogger;
import com.facebook.login.LoginManager;
import com.facebook.login.LoginResult;
import com.facebook.Profile;
import com.facebook.share.ShareApi;
import com.facebook.share.Sharer;
import com.facebook.share.model.ShareLinkContent;
import com.facebook.share.widget.ShareDialog;

import java.util.ArrayList;
import java.util.List;
import java.util.Arrays;

import org.json.JSONException;
import org.json.JSONObject;

public class MainActivity extends org.qtproject.qt5.android.bindings.QtActivity
{
    private native void resume();
    private native void pause();
    private native void loginFinished(boolean isSuccess, String result);
    private native void logoutFinished(boolean isSuccess);
    private native void withdrawFinished(boolean isSuccess);
    private native void inviteFinished(boolean isSuccess);
    private native void notifyTokenInfo(boolean isSuccess, String result);

//    public static final String TAG = "MainActivity";
//    private static final String GCM_PROJECT_ID_KEY = "org.koreatech.trizcontradiction.GcmProjectId";
    private static final int PLAY_SERVICES_RESOLUTION_REQUEST = 9000;

    // SharedPreferences에 저장할 때 key 값으로 사용됨.
    public static final String PROPERTY_REG_ID = "registration_id";

    // SharedPreferences에 저장할 때 key 값으로 사용됨.
    private static final String PROPERTY_APP_VERSION = "appVersion";
    private static final String TAG = "TRIZ";
    String SENDER_ID = "610302197588";

    GoogleCloudMessaging gcm;
    SharedPreferences prefs;
    Context context;
    String regid;

    public enum LoginType
    {
        NONE(0), EMAIL(1), KAKAO(2), FACEBOOK(3);
        private int value;
        private LoginType(int value)
        {
            this.value = value;
        }
        public int getValue()
        {
            return this.value;
        }
    }
    private LoginType requestedSNSType = LoginType.NONE; /* 0:로그인X, 1:이메일, 2:카카오, 3:페이스북 */

    private SessionCallback callback;
    private CallbackManager callbackManager;

    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        super.onCreate(savedInstanceState);

        context = getApplicationContext();
        if(checkPlayServices()) {
            gcm = GoogleCloudMessaging.getInstance(this);
            regid = getRegistrationId(context);
            Log.d("ANDROID Registration ID >>", regid);
            if (regid.isEmpty()) {
                registerInBackground();
            }
        } else {
            Log.i(TAG, "No valid Google Play Services APK found.");
        }

        callback = new SessionCallback();
        Session.getCurrentSession().addCallback(callback);

        AppEventsLogger.activateApp(getApplication());
        callbackManager = CallbackManager.Factory.create();
    }

    @Override
    public void onResume()
    {
        super.onResume();
//        MainApplication.setCurrentActivity(this);
//        resume();
        checkPlayServices();
    }

    @Override
    protected void onPause()
    {
        pause();
        super.onPause();
    }

    @Override
    protected void onDestroy()
    {
        super.onDestroy();
        Session.getCurrentSession().removeCallback(callback);
    }

    public String getDeviceId()
    {
        String deviceId = "";
        final TelephonyManager tm = (TelephonyManager) getApplicationContext().getSystemService(Context.TELEPHONY_SERVICE);
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            String imei = tm.getImei();
            deviceId = imei == null? tm.getMeid() : imei;
        } else {
            deviceId = tm.getDeviceId();
        }
        return deviceId;
    }

    private String getRegistrationId(Context context) {
        final SharedPreferences prefs = getGCMPreferences(context);
        String registrationId = prefs.getString(PROPERTY_REG_ID, "");
        if (registrationId.isEmpty()) {
            Log.i(TAG, "Registration not found.");
            return "";
        }

        // 앱이 업데이트 되었는지 확인하고, 업데이트 되었다면 기존 등록 아이디를 제거한다.
        // 새로운 버전에서도 기존 등록 아이디가 정상적으로 동작하는지를 보장할 수 없기 때문이다.
        int registeredVersion = prefs.getInt(PROPERTY_APP_VERSION, Integer.MIN_VALUE);
        int currentVersion = getAppVersion(context);
        if (registeredVersion != currentVersion) {
            Log.i(TAG, "App version changed.");
            return "";
        }
        return registrationId;
    }

    private SharedPreferences getGCMPreferences(Context context) {
        return getSharedPreferences(MainActivity.class.getSimpleName(),
                Context.MODE_PRIVATE);
    }

    private static int getAppVersion(Context context) {
        try {
            PackageInfo packageInfo = context.getPackageManager()
                    .getPackageInfo(context.getPackageName(), 0);
            return packageInfo.versionCode;
        } catch (PackageManager.NameNotFoundException e) {
            // should never happen
            throw new RuntimeException("Could not get package name: " + e);
        }
    }

    private boolean checkPlayServices() {

        int resultCode = GoogleApiAvailability.getInstance().isGooglePlayServicesAvailable(this);

        if (resultCode != ConnectionResult.SUCCESS) {
            if (GooglePlayServicesUtil.isUserRecoverableError(resultCode)) {
                GooglePlayServicesUtil.getErrorDialog(resultCode, this, PLAY_SERVICES_RESOLUTION_REQUEST).show();
            } else {
                Log.i("ICELANCER", "This device is not supported.");
                finish();
            }
            return false;
        }
        return true;
    }
    private void registerInBackground() {
        new AsyncTask<Void, Void, String>() {
            @Override
            protected String doInBackground(Void... params) {
                String msg = "";
                try {
                    if (gcm == null) {
                        gcm = GoogleCloudMessaging.getInstance(context);
                    }

                    regid = gcm.register(SENDER_ID);
                    msg = "Device registered, registration ID=" + regid;
                    Log.d("ANDROID Registration ID >>", regid);
                    // 서버에 발급받은 등록 아이디를 전송한다.
                    // 등록 아이디는 서버에서 앱에 푸쉬 메시지를 전송할 때 사용된다.
                    sendRegistrationIdToBackend();

                    // 등록 아이디를 저장해 등록 아이디를 매번 받지 않도록 한다.
                    storeRegistrationId(context, regid);
                } catch (IOException ex) {
                    msg = "Error :" + ex.getMessage();
                    // If there is an error, don't just keep trying to register.
                    // Require the user to click a button again, or perform
                    // exponential back-off.
                }
                return msg;
            }

            @Override
            protected void onPostExecute(String msg) {
//                mDisplay.append(msg + "\n");
                Log.d("GET PUSH", "PUSHED~");
            }

        }.execute(null, null, null);
    }

    private void storeRegistrationId(Context context, String regid) {
        final SharedPreferences prefs = getGCMPreferences(context);
        int appVersion = getAppVersion(context);
        Log.i(TAG, "Saving regId on app version " + appVersion);
        SharedPreferences.Editor editor = prefs.edit();
        editor.putString(PROPERTY_REG_ID, regid);
        editor.putInt(PROPERTY_APP_VERSION, appVersion);
        editor.commit();
    }

    private void sendRegistrationIdToBackend() {

    }

    public void loginKakao()
    {
        requestedSNSType = LoginType.KAKAO;
        new KaKaoLoginControl(MainActivity.this).call();
    }

    public void logoutKakao()
    {
        UserManagement.requestLogout(new LogoutResponseCallback() {
            @Override
            public void onCompleteLogout() {
                logoutFinished(true);
            }
        });
    }

    public void withdrawKakao()
    {
        UserManagement.requestUnlink(new UnLinkResponseCallback() {
            @Override
            public void onFailure(ErrorResult errorResult) {
                withdrawFinished(false);
            }

            @Override
            public void onSessionClosed(ErrorResult errorResult) {
                withdrawFinished(false);
            }

            @Override
            public void onNotSignedUp() {
                /* No Anything... */
            }

            @Override
            public void onSuccess(Long result) {
                withdrawFinished(true);
            }
        });
    }

    private KakaoLink kLink = null;
    private KakaoTalkLinkMessageBuilder ktMsgBuilder = null;
    public void inviteKakao(String senderId, String image, String title, String desc, String link)
    {
        if(kLink == null || ktMsgBuilder == null)
        {
          try {
            kLink = KakaoLink.getKakaoLink(getApplicationContext());
            ktMsgBuilder = kLink.createKakaoTalkLinkMessageBuilder();
          } catch (KakaoParameterException e) {
            e.printStackTrace();
            inviteFinished(false);
          }
        }
        if(ktMsgBuilder != null)
        {
            try {
                ktMsgBuilder.addImage("http://vlee.kr/wp-content/uploads/2017/03/%EB%B0%A4%ED%8E%B8%EC%A7%80_%EB%B9%84%ED%95%98%EC%9D%B8%EB%93%9C_18.jpg", 150, 150);
                ktMsgBuilder.addText("아이유가 참 예쁘죠.");
                ktMsgBuilder.addAppButton("앱 설치로 이동");
                ktMsgBuilder.addAppLink(getString(R.string.app_name_en),
                    new AppActionBuilder().addActionInfo(AppActionInfoBuilder.createAndroidActionInfoBuilder().build()).build());
                kLink.sendMessage(ktMsgBuilder, this);
                inviteFinished(true);
            } catch (KakaoParameterException e) {
                e.printStackTrace();
                inviteFinished(false);
            }
        }
    }

    private class SessionCallback implements ISessionCallback {
        @Override
        public void onSessionOpened() {

            /* REQUEST ME. */
            List<String> propertyKeys = new ArrayList<String>();
            propertyKeys.add("kaccount_email");
            propertyKeys.add("nickname");
            propertyKeys.add("profile_image");
            propertyKeys.add("thumbnail_image");

            UserManagement.requestMe(new MeResponseCallback() {
                @Override
                public void onFailure(ErrorResult errorResult)
                {
                    String message = "failed to get use rinfo. msg=" + errorResult;

                    String result = "";
                    JSONObject jObj = new JSONObject();
                    try {
                        jObj.put("is_logined", false);
                        jObj.put("error_message", message);
                        result = jObj.toString();
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }

                    loginFinished(true, result);
                }

                @Override
                public void onSessionClosed(ErrorResult errorResult)
                {
                    String message = "failed to get use rinfo. msg=" + errorResult;

                    String result = "";
                    JSONObject jObj = new JSONObject();
                    try {
                        jObj.put("is_logined", false);
                        jObj.put("error_message", message);
                        result = jObj.toString();
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }

                    loginFinished(true, result);
                }

                @Override
                public void onNotSignedUp()
                {
                    /* WHEN ALREADY SIGNED UP. */
                }

                @Override
                public void onSuccess(UserProfile userProfile)
                {
                    requestAccessTokenInfo();

                    String result = "";
                    JSONObject jUserProfile = new JSONObject();
                    try {
//                        jUserProfile.put("is_logined", false); /* 카카오톡은 매번 이쪽으로 진입. 따라서, false */
                        jUserProfile.put("is_logined", true);
                        jUserProfile.put("nickname", userProfile.getNickname());
                        jUserProfile.put("email", userProfile.getEmail());
                        jUserProfile.put("thumbnail_image", userProfile.getThumbnailImagePath());
                        jUserProfile.put("profile_image", userProfile.getProfileImagePath());
                        result = jUserProfile.toString();
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }

                    loginFinished(true, result);
                }
            }, propertyKeys, false);
        }

        private void requestAccessTokenInfo() {
            AuthService.requestAccessTokenInfo(new ApiResponseCallback<AccessTokenInfoResponse>() {
                @Override
                public void onSessionClosed(ErrorResult errorResult) {

                    String message = "failed to get access token info. msg=" + errorResult;
                    notifyTokenInfo(false, message);
                }

                @Override
                public void onNotSignedUp() {
                    // not happened
                }

                @Override
                public void onFailure(ErrorResult errorResult) {
                    String message = "failed to get token info. msg=" + errorResult;
                    notifyTokenInfo(false, message);
                }

                @Override
                public void onSuccess(AccessTokenInfoResponse accessTokenInfoResponse) {
                    long userId = accessTokenInfoResponse.getUserId();
//                    Logger.d("this access token is for userId=" + Long.toString(userId));

                    long expiresInMilis = accessTokenInfoResponse.getExpiresInMillis();
                    Logger.d("this access token expires after " + expiresInMilis + " milliseconds.");
                    notifyTokenInfo(true, Long.toString(userId));
                }
            });
        }

        @Override
        public void onSessionOpenFailed(KakaoException exception) {
            if(exception != null) {
                Logger.e(exception);
            }
            loginFinished(false, "Can't Open Failed.");
        }
    }

    public void loginFacebook()
    {
        AccessToken token = AccessToken.getCurrentAccessToken();
        if(token != null) {
            String result = "";
            JSONObject jUserProfile = new JSONObject();
            try {
                jUserProfile.put("is_logined", true);
                result = jUserProfile.toString();
            } catch (JSONException e) {
                e.printStackTrace();
            }

            loginFinished(true, result);
            return;
        }

        requestedSNSType = LoginType.FACEBOOK;
        List<String> permissionNeeds= Arrays.asList(/*"user_photos, publish_actions", */"email, ");
        LoginManager.getInstance().logInWithReadPermissions(MainActivity.this, permissionNeeds);
        LoginManager.getInstance().registerCallback(callbackManager, new
                FacebookCallback<LoginResult>() {
                    @Override
                    public void onSuccess(LoginResult loginResult) {
                        Log.d("TAG", "FACEBOOK TOKEN >> " + loginResult.getAccessToken().getToken());
                        Log.d("TAG", "FACEBOOK UserID >> " + loginResult.getAccessToken().getUserId());

                        GraphRequest graphRequest = GraphRequest.newMeRequest(loginResult.getAccessToken(), new GraphRequest.GraphJSONObjectCallback() {
                            @Override
                            public void onCompleted(JSONObject object, GraphResponse response) {
                                Log.d("result", object.toString());

                                String result = "";
                                JSONObject jUserProfile = new JSONObject();
                                try {
                                    jUserProfile.put("is_logined", false);
                                    jUserProfile.put("nickname", object.getString("name"));
                                    jUserProfile.put("email", object.getString("email"));

                                    Profile profile = Profile.getCurrentProfile();
                                    String profile_image = profile.getProfilePictureUri(200, 200).toString();

                                    jUserProfile.put("thumbnail_image", profile_image);
                                    jUserProfile.put("profile_image", profile_image);
                                    result = jUserProfile.toString();
                                } catch (JSONException e) {
                                    e.printStackTrace();
                                }

                                loginFinished(true, result);
                            }
                        });

                        Bundle parameters = new Bundle();
                        parameters.putString("fields", "id,name,email,gender,birthday");
                        graphRequest.setParameters(parameters);
                        graphRequest.executeAsync();
                    }

                    @Override
                    public void onCancel() {
                        Log.d("TAG", "CANCEL");
                    }

                    @Override
                    public void onError(FacebookException error) {

                        String result = "";
                        JSONObject jUserProfile = new JSONObject();
                        try {
                            jUserProfile.put("is_logined", true);
                            jUserProfile.put("error_message", error.toString());
                            result = jUserProfile.toString();
                        } catch (JSONException e) {
                            e.printStackTrace();
                        }

                        loginFinished(false, result);
                        error.printStackTrace();
                    }
                });
    }

    public void logoutFacebook()
    {
        LoginManager.getInstance().logOut();

        AccessToken token = AccessToken.getCurrentAccessToken();
        boolean isSuccess = true;
        if(token != null)   /* failed to logout. */
            isSuccess = false;

        logoutFinished(isSuccess);
    }

    public void withdrawFacebook()
    {
        /* make the API call */
        new GraphRequest(
            AccessToken.getCurrentAccessToken(),
            "/me/permissions",
            null,
            HttpMethod.DELETE,
            new GraphRequest.Callback() {
                public void onCompleted(GraphResponse response) {

                    try {
                        boolean isSuccess = response.getJSONObject().getBoolean("success");
                        withdrawFinished(isSuccess);

                        if(isSuccess) /* when succeed to withdraw. */
                            logoutFacebook();

                    } catch (JSONException e) {
                        Log.e("Facebook", "Error fetching JSON");
                    }
                }
            }
        ).executeAsync();
    }

    public void inviteFacebook(String senderId, String image, String title, String desc, String link) {

        ShareLinkContent content = new ShareLinkContent.Builder()
            .setContentUrl(Uri.parse("http://www.naver.com"))
            .setQuote("Connect on a global scale.")
//            .setContentTitle("TEST")
//            .setImageUrl(Uri.parse("http://vlee.kr/wp-content/uploads/2017/03/%EB%B0%A4%ED%8E%B8%EC%A7%80_%EB%B9%84%ED%95%98%EC%9D%B8%EB%93%9C_18.jpg"))
//            .setContentDescription("TEST...")
            .build();

//        ShareApi.share(content, new FacebookCallback<Sharer.Result>()
//        {
//            @Override
//            public void onSuccess(Sharer.Result result)
//            {
//                Log.d("[NATIVE_FACEBOOK]", "SHARE SUCCESS.");
//            }

//            @Override
//            public void onCancel()
//            {
//                Log.d("[NATIVE_FACEBOOK]", "SHARE CANCEL.");
//            }

//            @Override
//            public void onError(FacebookException e)
//            {
//                Log.d("[NATIVE_FACEBOOK]", "SHARE ERROR.");
//            }
//         });
        ShareDialog shareDialog = new ShareDialog(this);
        shareDialog.show(content, ShareDialog.Mode.AUTOMATIC);
    }

    public void inviteSMS(String message)
    {
      Intent intent = new Intent(Intent.ACTION_VIEW);
      intent.putExtra("sms_body", message);
      intent.setType("vnd.android-dir/mms-sms");
      startActivity(intent);
    }

    public void inviteEmail(String message)
    {
      Intent intent = new Intent(Intent.ACTION_SEND);
      intent.putExtra(Intent.EXTRA_TEXT, message);
      intent.setType("message/rfc822");
      startActivity(Intent.createChooser(intent, "Email"));
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        switch(requestedSNSType)
        {
            case NONE:
            case EMAIL:
                break;
            case KAKAO:
            {
                if(Session.getCurrentSession().handleActivityResult(requestCode, resultCode, data))
                    return;
                break;
            }
            case FACEBOOK:
            {
                callbackManager.onActivityResult(requestCode, resultCode, data);
                break;
            }
        }

        requestedSNSType = LoginType.NONE;
    }
}
