import { NativeModules } from 'react-native';
const umengClient = NativeModules.Umeng;

export default class MobclickAgent{

    static setCrashReportEnabled(value){
        umengClient.setCrashReportEnabled(true);
    }

    static startWithAppkey(value){
        umengClient.startWithAppkey(value);
    }

    //iOS
    static setBackgroundTaskEnabled(value){
    }

    static enableEncrypt(value){
        umengClient.enableEncrypt(value);
    }

    static onProfileSignIn(puid,provider = undefined){
        umengClient.onProfileSignIn(puid,provider);
    }
    static onProfileSignOff(){
        umengClient.onProfileSignOff();
    }
    static onPageStart(pageName){
        umengClient.onPageStart(pageName);
    }

    static onPageEnd(pageName){
        umengClient.onPageEnd(pageName);
    }

    //iOS
    static onLogPageViewInseconds(pageName,du = 0){
        umengClient.logPageView(pageName,du);
    }

    static onEvent(eventId,dataMap = undefined,counter = undefined){
        console.log("onEvent"+ dataMap);

        if (counter !== undefined) {
            counter = counter + '';
        }
        umengClient.onEvent(eventId,dataMap,counter);

    }

    static setDebugMode(value){
        umengClient.setDebugMode(value);
    }
    static setLogEnabled(value){
        umengClient.setDebugMode(value);
    }

    //android
    static openActivityDurationTrack(value){

    }

    static getDeviceInfo(){
        umengClient.getDeviceInfo();
    }


}
