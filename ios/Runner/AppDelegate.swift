import UIKit
import Flutter
import UserNotifications


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {


        if #available(iOS 10.0, *) {
              UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
          }



    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }




    override func applicationWillResignActive(
       _ application: UIApplication
     ) {
       self.window.isHidden = true;
     }
     override func applicationDidBecomeActive(
       _ application: UIApplication
     ) {
       self.window.isHidden = false;
     }
    
    
    
}
