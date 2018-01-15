package net.techpda.snslogin;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import com.facebook.CallbackManager;
import com.kakao.auth.ApiResponseCallback;
import com.kakao.auth.AuthService;
import com.kakao.auth.AuthType;
import com.kakao.auth.ISessionCallback;
import com.kakao.auth.Session;
import com.kakao.auth.network.response.AccessTokenInfoResponse;
import com.kakao.network.ErrorResult;
import com.kakao.usermgmt.UserManagement;
import com.kakao.usermgmt.callback.UnLinkResponseCallback;
import com.kakao.util.exception.KakaoException;
import com.kakao.util.helper.log.Logger;

/**
 * Created by JHKim on 2018-01-13.
 */

public class KakaoLoginActivity extends Activity {
    private SessionCallback callback;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_user_kakao);

        Button btnKakaoLogin = (Button) findViewById(R.id.btnKakaoLogin);
        btnKakaoLogin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                new KaKaoLoginControl(KakaoLoginActivity.this).call();
            }
        });

        Button btnKakaoDisconnect = (Button) findViewById(R.id.btnKakaoDisconnectApp);
        btnKakaoDisconnect.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onClickUnlink();
            }
        });

        callback = new SessionCallback();
        Session.getCurrentSession().addCallback(callback);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        Session.getCurrentSession().removeCallback(callback);
    }

    private class SessionCallback implements ISessionCallback {
        @Override
        public void onSessionOpened() {
            redirectSignupActivity();
        }

        @Override
        public void onSessionOpenFailed(KakaoException exception) {
            if(exception != null) {
                Logger.e(exception);
            }

            setContentView(R.layout.activity_user_kakao);
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
     if(Session.getCurrentSession().handleActivityResult(requestCode, resultCode, data)) {
         return;
     }
     super.onActivityResult(requestCode, resultCode, data);
    }

    protected void redirectSignupActivity() {
        final Intent intent = new Intent(this, KakaoSignupActivity.class);
        intent.setFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
        startActivity(intent);
        finish();
    }

    protected void redirectMainActivity() {
        final Intent intent = new Intent(KakaoLoginActivity.this, MainActivity.class);
        startActivity(intent);
        finish();
    }

    public void onClickUnlink()
    {
        final String appendMessage = getString(R.string.com_kakao_confirm_unlink);
        new AlertDialog.Builder(this)
                .setMessage(appendMessage)
                .setPositiveButton(getString(R.string.com_kakao_ok_button),
                        new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog, int which) {
                                UserManagement.requestUnlink(new UnLinkResponseCallback() {
                                    @Override
                                    public void onFailure(ErrorResult errorResult) {
                                        Logger.e(errorResult.toString());
                                    }

                                    @Override
                                    public void onSessionClosed(ErrorResult errorResult) {
                                        redirectMainActivity();
                                    }

                                    @Override
                                    public void onNotSignedUp() {
                                        redirectSignupActivity();
                                    }

                                    @Override
                                    public void onSuccess(Long result) {
                                        redirectMainActivity();
                                    }
                                });
                                dialog.dismiss();
                            }
                        }).setNegativeButton(getString(R.string.com_kakao_cancel_button),
                new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which)
                    {
                        dialog.dismiss();
                    }
                }).show();

    }

//    https://stackoverflow.com/questions/29305232/facebook-sdk-4-for-android-how-to-log-out-programmatically 페이스북 앱 여ㅑㄴ결 해제

}
