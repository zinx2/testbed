package net.techpda.snslogin;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;


import com.facebook.login.LoginManager;
import com.kakao.auth.ApiResponseCallback;
import com.kakao.auth.AuthService;
import com.kakao.auth.network.response.AccessTokenInfoResponse;

import com.kakao.network.ErrorResult;
import com.kakao.usermgmt.UserManagement;
import com.kakao.usermgmt.callback.LogoutResponseCallback;
import com.kakao.usermgmt.callback.MeResponseCallback;
import com.kakao.usermgmt.response.model.UserProfile;
import com.kakao.util.helper.log.Logger;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by JHKim on 2018-01-13.
 */

public class HomeActivity extends Activity {
    @Override
    protected void onCreate(final Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);

        Button btnKakaoLogout = (Button) findViewById(R.id.btnKakaoLogout);
        btnKakaoLogout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                logoutKakao();
            }
        });

        Button btnFacebookLogout = (Button) findViewById(R.id.btnFacebookLogout);
        btnFacebookLogout.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {
                logoutFacebook();
            }
        });
    }

    protected void redirectLoginActivity() {
        final Intent intent = new Intent(this, MainActivity.class);
//        intent.setFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
        startActivity(intent);
        finish();
    }

    public void logoutKakao()
    {
        UserManagement.requestLogout(new LogoutResponseCallback() {
            @Override
            public void onCompleteLogout() {
                redirectLoginActivity();
            }
        });
    }

    public void logoutFacebook()
    {
        LoginManager.getInstance().logOut();
        redirectLoginActivity();
    }

//    protected void requestMe() {
//        List<String> propertyKeys = new ArrayList<String>();
//        propertyKeys.add("kaccount_email");
//        propertyKeys.add("nickname");
//        propertyKeys.add("profile_image");
//        propertyKeys.add("thumbnail_image");
//
//        UserManagement.requestMe(new MeResponseCallback() {
//                                     @Override
//                                     public void onFailure(ErrorResult errorResult)
//                                     {
//                                         String message = "failed to get use rinfo. msg=" + errorResult;
//                                         Logger.d(message);
////                                         redirectLoginActivity();;
//                                     }
//
//                                     @Override
//                                     public void onSessionClosed(ErrorResult errorResult)
//                                     {
//                                         Logger.d("ErrorResult : " + errorResult);
////                                         redirectLoginActivity();
//                                     }
//
//                                     @Override
//                                     public void onNotSignedUp()
//                                     {
//                                     }
//
//                                     @Override
//                                     public void onSuccess(UserProfile userProfile)s
//                                     {
//                                         Logger.d("UserProfile : " + userProfile);
//                                         Log.d("user", userProfile.toString());
//                                     }
//                                 }
//        );
////        , propertyKeys, false);
//    }


//    public void requestAccessTokenInfo() {
//
//        AuthService.requestAccessTokenInfo(new ApiResponseCallback<AccessTokenInfoResponse>() {
//            @Override
//            public void onSessionClosed(ErrorResult errorResult) {
//                //redirectLoginActivity(self);
//            }
//
//            @Override
//            public void onNotSignedUp() {
//                // not happened
//            }
//
//            @Override
//            public void onFailure(ErrorResult errorResult) {
//                Logger.e("failed to get access token info. msg=" + errorResult);
//            }
//
//            @Override
//            public void onSuccess(AccessTokenInfoResponse accessTokenInfoResponse) {
//                long userId = accessTokenInfoResponse.getUserId();
//                Logger.d("this access token is for userId=" + userId);
//
//                long expiresInMilis = accessTokenInfoResponse.getExpiresInMillis();
//                Logger.d("this access token expires after " + expiresInMilis + " milliseconds.");
//            }
//        });
//    }


}




