package ac.olei.testbed;

import android.app.Activity;
import android.content.Context;

import com.kakao.auth.AuthType;
import com.kakao.auth.Session;
import com.kakao.usermgmt.LoginButton;

import java.lang.reflect.Method;
import java.util.List;

/**
 * Created by JHKim on 2018-01-14.
 */

public class KaKaoLoginControl extends LoginButton {

    public KaKaoLoginControl(Context context) {
        super(context);
    }

    public void call()
    {
        try
        {
            Method methodGetAuthTypes = LoginButton.class.getDeclaredMethod("getAuthTypes");
            methodGetAuthTypes.setAccessible(true);
            final List<AuthType> authTypes = (List<AuthType>) methodGetAuthTypes.invoke(this);
            if(authTypes.size() == 1)
            {
                Session.getCurrentSession().open(authTypes.get(0), (Activity) getContext());
            } else {
                Method methodOnClickLoginButton = LoginButton.class.getDeclaredMethod("onClickLoginButton", MainActivity.class);
                methodOnClickLoginButton.setAccessible(true);
                methodOnClickLoginButton.invoke(this, authTypes);
            }
        } catch (Exception e) {
            Session.getCurrentSession().open(AuthType.KAKAO_ACCOUNT, (Activity) getContext());
        }
    }
}
