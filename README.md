# React Native Umeng

A Umeng lib for React Native

# iOS Install

在 `package.json` 里添加:  

```
"rn-umeng": "git+https://github.com/RnTouna/rn-umeng.git"
```

然后执行命令

```bash
yarn install (或 npm install)
react-native link rn-umeng
```

在工程target的 `Build Phases->Link Binary with Libraries` 中加入
`CoreTelephony.framework libz.tbd libsqlite3.tbd`

在 `Build Settings->Search Paths->Framework Search Paths` 中加入路径 `$(SRCROOT)/../node_modules/rn-umeng/ios/RCTUmeng/RCTUmeng/UMAnalytics_Sdk`

在 `Build Settings->Link->Other Linker Flags` 中加入 `-framework "UMMobClick"`

# Android Install (Manual)

```bash
$ npm install --save rn-umeng
```

#### Add Gradle Module Manually
1.Right click app in Android project, Choose Open Module Setting, Click Add button and then Click Import Gradle Project in New Module window.

2.Navigator to the Module Source, type the name as " react_native_ument "
Module Path:
```bash
$PROJECT_DIR/node_modules/rn-umeng/android
```
![image](https://raw.githubusercontent.com/cbcye/rn-umeng/master/screenshots/Import%20Gradle%20Project.png)

3.Add app dependencies
![image](https://raw.githubusercontent.com/cbcye/rn-umeng/master/screenshots/Add%20app%20dependencies.png)


#### Add UmengPackage
The following steps is working in RN 0.31, other version just make reference.

Add following code in the MainApplication
```java
import in.esseak.react_native_umeng.UmengPackage; //add this

@Override
        protected List<ReactPackage> getPackages() {
            return Arrays.<ReactPackage>asList(
                    new MainReactPackage(),
                    new UmengPackage() //add this
            );
        }
```

#### onResume and onPause
Add following code in the MainActivity
```java
import com.umeng.analytics.MobclickAgent;

public class MainActivity extends ReactActivity {
 ...
//start add code 
            @Override
        protected void onResume() {
            super.onResume();
            MobclickAgent.onResume(this);
        }

        @Override
        protected void onPause() {
            super.onPause();
            MobclickAgent.onPause(this);
        }
//end add code 
}

```

# Usage

The api mapping below

React Native Side        | iOS Side           | Android Side   
--------------------------|---------------------|-----------------------
startWithAppkey(string)   | startWithAppkey(NSString)   | AnalyticsConfig.setAppkey(String appkey)
startWithAppkeyAndChannel(string,string)   | N/A   | UMAnalyticsConfig(Context context, String appkey, String channelId)  
setAppVersion(string)     | setAppVersion(string)       | Not need to set it
setDebugMode(bool)        | setLogEnabled(BOOL)         | MobclickAgent.setDebugMode( true )  
enableEncrypt(boole)      | setEncryptEnabled(BOOL)          | AnalyticsConfig.enableEncrypt(boolean enable)   
setCrashReportEnabled(boole)      | setCrashReportEnabled(BOOL)           | MobclickAgent.setCatchUncaughtExceptions(false)
onEvent(string)      |event:(NSString *)eventId           | MobclickAgent.onEvent(Context context, String eventId)
onEvent(string,{key:"value"})      | onEvent:(NSString *)eventId attributes:(NSDictionary *)attributes           | MobclickAgent.onEvent(Context context, String eventId, HashMap map)
onEvent(string,{key:"value"},0)    | onEvent:(NSString *)eventId attributes:(NSDictionary *)attributes counter:(NSString *)counter           | MobclickAgent.onEventValue(Context context, String id, Map<String,String> m, int du)
onProfileSignIn('ID')      | profileSignInWithPUID:(NSString *)puid           | onProfileSignIn(String ID)
onProfileSignIn('ID','Provider')      | profileSignInWithPUID:(NSString *)puid provider:(NSString *)provider           | onProfileSignIn(String Provider, String ID)
onProfileSignOff()      | profileSignOff           | onProfileSignOff()
onPageStart(string)      | beginLogPageView:(NSString *)pageName           | MobclickAgent.onPageStart(String pageName)
onPageEnd(string)      | endLogPageView:(NSString *)pageName           | MobclickAgent.onPageEnd(String pageName)
onLogPageViewInseconds('pageName',10)      | logPageView:pageName seconds:seconds          | N/A
openActivityDurationTrack(boole)      |  N/A           | MobclickAgent.openActivityDurationTrack(boolean value)
onResume()      | N/A           | MobclickAgent.onResume()
onPause()      | N/A            | MobclickAgent.onPause()
getDeviceInfo((infoStr)=>{})      | getDeviceInfo           | getDeviceInfo

In your project code

```javascript
import MobclickAgent from 'rn-umeng';
MobclickAgent.startWithAppkey('your appkey');
MobclickAgent.setDebugMode(true);
MobclickAgent.onEvent("testEvent");
```


# Changelog


### - 1.0.6
 - support RN 0.40

### - 1.0.5

 - fix error in LazyReactPackage

### - 1.0.4

 - add Android channel set

### - 1.0.3

 - add Android lib (but Manually,rnpm link not works,fix later)
 - update readme.md


### - 1.0.2
 - Project initialization

# License
MIT


