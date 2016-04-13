# React Native Umeng

A Umeng lib for React Native (current iOS only,Android coming soon)

# Install

```bash
$ npm install --save rn-umeng
$ rnpm link rn-umeng
```

# Usage

The api mapping below

React Native Silde        | iOS Silde           | Android Silde   
--------------------------|---------------------|-----------------------
startWithAppkey(string)   | startWithAppkey(NSString)   | coming soon   
setDebugMode(bool)        | setLogEnabled(BOOL)         | coming soon   
enableEncrypt(boole)      | setEncryptEnabled(BOOL)          | coming soon   
setCrashReportEnabled(boole)      | setCrashReportEnabled(BOOL)           | coming soon
onEvent(string)      |event:(NSString *)eventId           | coming soon
onEvent(string,{key:"value"})      | onEvent:(NSString *)eventId attributes:(NSDictionary *)attributes           | coming soon
onEvent(string,{key:"value"},0)    | onEvent:(NSString *)eventId attributes:(NSDictionary *)attributes counter:(NSString *)counter           | coming soon
onPageStart(string)      | onPageStart:(NSString *)pageName           | coming soon
onPageEnd(string)      | onPageEnd:(NSString *)pageName           | coming soon
getDeviceInfo      | getDeviceInfo           | coming soon

# Changelog
- ### 1.0.1
 - Project initialization

# License
MIT
