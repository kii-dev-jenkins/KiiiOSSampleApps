#Getting Started with the Sample App

## Requirements

- Mac OS X running a recent version of Xcode

- iOS SDK 4.0 or later

## Installation and setup

1. Download the project <a href="https://github.com/kii-dev-jenkins/KiiiOSSampleApps/tree/master/KiiAdSampleApp">here</a>

2. Open KiiAdSampleApp.xcodeproj in Xcode

3. Choose the iPhone Simulator as a target

4. Click 'Build & Run'
> If you have issues building, ensure that your Targets > Build Settings > Base SDK is set to "Latest"

<br><br><br><br>

#Getting Started with the Framework

## Installation and setup

1. Download the SDK <a href="http://static.kii.com/devportal/production/download/ios_ads/KiiAdFramework.framework.zip">here</a>

2. Add to your project
> Drag the KiiAd.framework bundle into the 'Frameworks' group in your project.
3. Add the native SystemConfiguration framework to your project

4. Repeat step 3 so your project contains the following frameworks:
>- SystemConfiguration
>- AudioToolbox
>- CoreLocation
>- MediaPlayer
>- AVFoundation
>- libsqlite3.dylib
>- CoreTelephony
>- QuartzCore
>- MobileCoreServices
>- CoreMotion
>- MessageUI

## Display ads in your application

1. In your project, open the view controller you want to place your ad in. Example: MyViewController.m

2. Place the following code in your viewDidLoad method:

<pre><code>
	KiiAdnet *adView = [KiiAdnet requestAdWithDelegate:self
									 withApplicationId:@"&lt;my-application-id&gt;"
                                 	 andApplicationKey:@"&lt;my-application-key&gt;"];

	[self.view addSubview:adView];
</code></pre>


# Learn more

If you'd like to see complete, in-depth documentation of the Ad SDK, you can continue to the documentation <a href="http://static.kii.com/devportal/production/docs/ios_ads/">here</a>.
