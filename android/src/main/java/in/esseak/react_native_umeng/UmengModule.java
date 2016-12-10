package in.esseak.react_native_umeng;

import android.Manifest;
import android.annotation.SuppressLint;
import android.content.Context;
import android.content.pm.PackageManager;
import android.os.Build;
import android.text.TextUtils;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.ReadableMapKeySetIterator;
import com.umeng.analytics.AnalyticsConfig;
import com.umeng.analytics.MobclickAgent;

import java.util.HashMap;

/**
 * Created by mike on 16/4/26.
 */
public class UmengModule extends ReactContextBaseJavaModule {

    private static Boolean startedWithAppkey = false;
    private Context context;
    public UmengModule(ReactApplicationContext reactContext) {
        super(reactContext);
        context = reactContext.getBaseContext();
    }

    @Override
    public String getName() {
        return "Umeng";
    }

    @ReactMethod
    public void startWithAppkey(String value){
        if (!startedWithAppkey){
            AnalyticsConfig.setAppkey(context,value);
            AnalyticsConfig.setChannel("android");
            startedWithAppkey = true;
        }
    }

    @ReactMethod
    public void startWithAppkeyAndChannel(String value,String channel){
        if (!startedWithAppkey){
            AnalyticsConfig.setAppkey(context,value);
            AnalyticsConfig.setChannel(channel);
            startedWithAppkey = true;
        }
    }

    @ReactMethod
    public void setCrashReportEnabled(Boolean value){
        MobclickAgent.setCatchUncaughtExceptions(value);
    }

    @ReactMethod
    public void enableEncrypt(Boolean value){
        AnalyticsConfig.enableEncrypt(value);
    }

    @ReactMethod
    public void onPageStart(String pageName){
        MobclickAgent.onPageStart(pageName);
    }

    @ReactMethod
    public void onPageEnd(String pageName){
        MobclickAgent.onPageEnd(pageName);
    }

    @ReactMethod
    public void onProfileSignIn(String ID,String Provider){
        if (Provider != null){
            MobclickAgent.onProfileSignIn(Provider,ID);
        }else{
            MobclickAgent.onProfileSignIn(ID);
        }
    }

    @ReactMethod
    public void onProfileSignOff(){
        MobclickAgent.onProfileSignOff();
    }

    @ReactMethod
    public void onEvent(String eventId, ReadableMap dataMap, String counter){
        HashMap<String,String> map = null;
        if (dataMap != null){
            map = new HashMap<String,String>();
            ReadableMapKeySetIterator readableMapKeySetIterator = dataMap.keySetIterator();
            while (readableMapKeySetIterator.hasNextKey()){
                String aKey = readableMapKeySetIterator.nextKey();
                String aValue = dataMap.getString(aKey);
                map.put(aKey,aValue);
            }
        }

        if (map != null&&counter != null){
            MobclickAgent.onEventValue(context,eventId,map,Integer.parseInt(counter));
        }else if(map!=null){
            MobclickAgent.onEvent(context,eventId,map);
        }else{
            MobclickAgent.onEvent(context,eventId);
        }

    }

    @ReactMethod
    public void openActivityDurationTrack(Boolean value){
        MobclickAgent.openActivityDurationTrack(value);
    }

    @ReactMethod
    public void onResume(){
        MobclickAgent.onResume(context);
    }

    @ReactMethod
    public void onPause(){
        MobclickAgent.onPause(context);
    }

    @ReactMethod
    public void setDebugMode(Boolean value){
        MobclickAgent.setDebugMode(value);
    }

    @ReactMethod
    public void setLogEnabled(Boolean value){
        MobclickAgent.setDebugMode(value);
    }

    @ReactMethod
    public void getDeviceInfo(Callback dataCallBack){
        String infoStr = mGetDeviceInfo(context);
        dataCallBack.invoke(infoStr);
    }

    @SuppressLint("NewApi")

    public static boolean checkPermission(Context context, String permission) {
        boolean result = false;

        if (Build.VERSION.SDK_INT >= 23) {
            if (context.checkSelfPermission(permission) == PackageManager.PERMISSION_GRANTED) {
                result = true;
            }
        } else {
            PackageManager pm = context.getPackageManager();

            if (pm.checkPermission(permission, context.getPackageName()) == PackageManager.PERMISSION_GRANTED) {
                result = true;
            }
        }

        return result;
    }


    public static String mGetDeviceInfo(Context context) {
        try {
            org.json.JSONObject json = new org.json.JSONObject();
            android.telephony.TelephonyManager tm = (android.telephony.TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);

            String device_id = null;

            if (checkPermission(context, Manifest.permission.READ_PHONE_STATE)) {
                device_id = tm.getDeviceId();
            }

            android.net.wifi.WifiManager wifi = (android.net.wifi.WifiManager) context.getSystemService(Context.WIFI_SERVICE);

            String mac = wifi.getConnectionInfo().getMacAddress();

            json.put("mac", mac);

            if (TextUtils.isEmpty(device_id)) {
                device_id = mac;
            }


            if (TextUtils.isEmpty(device_id)) {
                device_id = android.provider.Settings.Secure.getString(context.getContentResolver(),
                        android.provider.Settings.Secure.ANDROID_ID);
            }

            json.put("device_id", device_id);

            return json.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}
