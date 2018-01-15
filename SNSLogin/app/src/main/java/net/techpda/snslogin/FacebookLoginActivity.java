package net.techpda.snslogin;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;

import com.facebook.CallbackManager;
import com.facebook.FacebookCallback;
import com.facebook.FacebookException;
import com.facebook.FacebookSdk;
import com.facebook.GraphRequest;
import com.facebook.GraphResponse;
import com.facebook.appevents.AppEventsLogger;
import com.facebook.login.LoginManager;
import com.facebook.login.LoginResult;

import org.json.JSONObject;

import java.util.Arrays;
import java.util.List;

/**
 * Created by JHKim on 2018-01-14.
 */

public class FacebookLoginActivity extends Activity {

    private CallbackManager callbackManager;

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
//        FacebookSdk.sdkInitialize(getApplicationContext());
        AppEventsLogger.activateApp(getApplication());
        setContentView(R.layout.activity_user_facebook);
        callbackManager = CallbackManager.Factory.create();


        /* if 자동 로그인 플래그 == true : */
            /* 토큰 검사 로직 */
            /* if 토큰 데이터필드 isEmpty == true : 로그인 화면 유지 */
            /* else */
                /* if 유효한 토큰 : loginFacebook(); -> 토큰이 갱신됨 */
                /* 유효한 토큰이란? 만료 기간이 초과하지 않은 토큰. */
                /* else :  refreshToken */

        Button btnFacebookLogin = (Button) findViewById(R.id.btnFacebookLogin);
        btnFacebookLogin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                loginFacebook();
            }
        });

        Button btnFacebookDisconnect = (Button) findViewById(R.id.btnFacebookDisconnectApp);
        btnFacebookDisconnect.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                LoginManager.getInstance().logOut();
            }
        });
    }

    public void loginFacebook()
    {
        List<String> permissionNeeds= Arrays.asList("user_photos", "email");
        LoginManager.getInstance().logInWithReadPermissions(FacebookLoginActivity.this, permissionNeeds);
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

                                final Intent intent = new Intent(FacebookLoginActivity.this, HomeActivity.class);
                                startActivity(intent);
                                finish();
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
                        error.printStackTrace();
                    }
                });
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data)
    {
        super.onActivityResult(requestCode, resultCode, data);
        callbackManager.onActivityResult(requestCode, resultCode, data);
    }
}
