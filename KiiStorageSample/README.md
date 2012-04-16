#Getting Started with the Sample App

## Requirements

- Mac OS X running a recent version of Xcode

- iOS SDK 4.0 or later

## Installation and setup

1. Download the project <a href="https://github.com/kii-dev-jenkins/KiiiOSSampleApps/tree/master/KiiStorageSample">here</a>

2. Open KiiStorageSample.xcodeproj in Xcode

3. Choose the iPhone Simulator as a target

4. Click 'Build & Run'
> If you have issues building, ensure that your Targets > Build Settings > Base SDK is set to "Latest"

<br><br><br><br>

#Getting Started with the Storage Framework

## About

The Kii Platform allows developers to utilize many tools to simplify development. Focus on your application by adding our easy to use client code to handle user management, object and file storage, and advertising.

## Installation and setup

1. Register with Kii for an Application ID and Application Key

2. Download the framework <a href="http://static.kii.com/devportal/production/download/ios_cloud/KiiSDK.framework.zip">here</a>

3. Drag the framework bundle into the 'Frameworks' section in your XCode project

4. Ensure the following frameworks exist in your project:
>- MobileCoreServices.framework

5. Add the following header to all files that will use Kii SDK:<pre><code>			#import &lt;KiiSDK/KiiClient.h&gt;</code></pre>

6. Add the following code in your app delegate's applicationDidFinishLaunching:withOptions: method:<pre><code>			[KiiClient beginWithID:@"&lt;application-id&gt;"
                		 	 andKey:@"&lt;application-key&gt;"];</code></pre>


<br><br>

# Learn more

If you'd like to see complete, in-depth documentation of the Kii SDK, you can continue to the documentation <a href="https://developer.kii.com/docs">here</a>.
