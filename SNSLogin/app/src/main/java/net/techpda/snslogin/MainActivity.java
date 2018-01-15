package net.techpda.snslogin;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.kakao.auth.ApprovalType;
import com.kakao.auth.AuthType;
import com.kakao.auth.IApplicationConfig;
import com.kakao.auth.ISessionConfig;
import com.kakao.auth.KakaoAdapter;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Button btnKakao = (Button) findViewById(R.id.btnKakao);
        btnKakao.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
//                Toast.makeText(MainActivity.this, "카카오", Toast.LENGTH_SHORT).show();
                Intent intent = new Intent(getApplicationContext(), KakaoLoginActivity.class);
                startActivity(intent);
            }
        });

        Button btnFacebook = (Button) findViewById(R.id.btnFacebook);
        btnFacebook.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
//                Toast.makeText(MainActivity.this, "페이스북", Toast.LENGTH_SHORT).show();
                Intent intent = new Intent(getApplicationContext(), FacebookLoginActivity.class);
                startActivity(intent);
            }
        });
    }
}
