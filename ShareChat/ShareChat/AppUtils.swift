//
//  AppUtils.swift
//  BaseProjectSwift
//
//  Created by Sufalam5 on 12/21/15.
//  Copyright © 2015 Sufalam Technologies. All rights reserved.
//

import UIKit

class AppUtils: NSObject {

    static var progressView : MBProgressHUD?
  
    static var inPasscodeScreen: Bool = false;
    static var appWasInactive: Bool = false;
    
    // MARK: Device Check
    static func isIPad() -> Bool{
        
        if(UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad){
            
            return true;
            
        }else{
            
            return false;
        }
    }
    static func isiPhone3_5inch() -> Bool{
        
        if(UIScreen.main.bounds.size.height <= 480.0){
            
            return true;
            
        }else{
            
            return false;
        }
    }
    static func isiPhone4inch() -> Bool{
        
        if(UIScreen.main.bounds.size.height == 568.0){
            
            return true;
            
        }else{
            
            return false;
        }
    }
    static func isiPhone6() -> Bool{
        
        if(UIScreen.main.bounds.size.height == 667.0){
            
            return true;
            
        }else{
            
            return false;
        }
    }
    static func isiPhone6Plus() -> Bool{
        
        if(UIScreen.main.bounds.size.height == 736.0){
            
            return true;
            
        }else{
            
            return false;
        }
    }
    
    // MARK: Appdelegate Object
    static func APPDELEGATE() -> AppDelegate{
        
        return UIApplication.shared.delegate as! AppDelegate;
    }
    
    // MARK: WebService use
    static func stringToDictionary(_ strToJSON : String)-> NSDictionary!{
        
        let data = strToJSON.data(using: String.Encoding.utf8)
        var dict : NSDictionary!;
        do {
            
            dict = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary;
            
            return dict;
            
        }
        catch let error as NSError {
            print("Error is:\(error)");
            
        }
        
        return dict;
        
    }
    
    // MARK: Validations
    static func validateEmail(_ strEmail : String)-> Bool{
        
        let emailRegex : String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex);
        
        return emailTest.evaluate(with: strEmail);
        
    }
    
    // MARK: Internet Check
    static func checkInternetHostReachability(_ HOST: String, completion: ((Bool) -> Void)?){
        //Checking Internet connection and Host reachability
        //Internect Check and HostReachability
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
//        let url = URL(string: "\(Constant.SCHEME)www.\(HOST)");
        //hiren
         let url = URL(string: "\(Constant.SCHEME)www.\(HOST)");
        
        let request = NSMutableURLRequest(url: url!);
        request.httpMethod = "HEAD";
        
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData;
        request.timeoutInterval = 5.0;
        let queue = OperationQueue.init();
        
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: queue) { (response, data, error) -> Void in
            
            if(response != nil){
                
                if((response as! HTTPURLResponse).statusCode == 200){
                    
                    //                    print("Response is:\(response)");
                    completion!(true);
                }else{
                    //                    print("Response is:failed");
                    completion!(false);
                }
            }else{
                
                completion!(false);
            }
        }
        
    }
    
    // MARK: Alert
    static func showAlertWithTitle(_ title: String, message : String, cancelButton: String = "OK"){
        
        UIAlertView.init(title: title, message: message, delegate: self, cancelButtonTitle: cancelButton).show();
        
    }

    
    static func showAlertWithTitle(_ title: String, message : String, cancelButton: String = "OK", tag : Int = 0, delegate: UIAlertViewDelegate){
        
        let alert : UIAlertView! = UIAlertView.init(title: title, message: message, delegate: delegate, cancelButtonTitle: cancelButton);
        alert.tag = tag;
        alert.show();
        
    }
    
    static func showAlertWithTitle(_ title: String, message : String, delegate: UIAlertViewDelegate, tag : Int, cancelButton: String = "YES", otherButton : String = "NO"){

        let alert : UIAlertView! = UIAlertView.init(title: title, message: message, delegate: delegate, cancelButtonTitle: cancelButton);
        alert.addButton(withTitle: otherButton);
        alert.tag = tag;
        alert.show();
        
        
    }
    
    // MARK: Loading View
    static func startLoading(_ view : UIView){
        
        progressView = MBProgressHUD.showAdded(to: view, animated: true);
        
    }
    static func startLoadingWithText(_ strText: String, view : UIView){
        
        progressView = MBProgressHUD.showAdded(to: view, animated: true);
        progressView?.labelText = strText;
        
    }
    static func stopLoading(){
        if self.progressView != nil {
            self.progressView!.hide(true);
        }
    }
    
    static func hudWasHidden(){
    }
    
    //MARK: - Round Layers
    static func roundLayer(_ layer: CALayer, width: CGFloat){
        
        layer.cornerRadius = width;
        layer.masksToBounds = true;
        
    }
    
    
    
    //MARK: Redirect to NoInternet screen
//    static func redirectToNoInternetScreen(_ handler : AnyObject){
//        
//        print("Internet connection is not available..............");
//
//        let controller = handler as! UIViewController;
//        
//        controller.navigationController?.isNavigationBarHidden = true;
//        
//        let childController: NoInternetController! = NoInternetController(nibName: "NoInternetController", bundle: nil) ;
//
//        childController.view.frame = (AppUtils.APPDELEGATE().window?.frame)!;
//        controller.view.addSubview(childController.view);
//        controller.addChildViewController(childController);
//        childController.didMove(toParentViewController: controller);
//        
//    }
    
    //MARK: Add and Remove child controller
//    static func addChildViewController(controller : UIViewController){
//        
//        controller.navigationController?.navigationBarHidden = false;
//        controller.willMoveToParentViewController(nil); // 1
//        controller.view.removeFromSuperview(); // 2
//        controller.removeFromParentViewController();
//        
//    }
    
    //MARK: - Add and Remove child controller
    static func addChildViewController(_ childController : UIViewController, controller : UIViewController, needToHideNavigationBar : Bool,navigationBackgroundColor : UIColor){
        
        if(needToHideNavigationBar){
            
            let viewAboveNavigationBar : UIView = UIView();
            
            print(viewAboveNavigationBar);
            print(controller);
            print(controller.navigationController);
            print(controller.navigationController?.navigationBar);
            viewAboveNavigationBar.frame = CGRect(x: 0, y: 0, width: (controller.navigationController?.navigationBar.frame.size.width)!, height: 64);
//            viewAboveNavigationBar.tag = Constant.POPUP_NAVIGATIONBAR_VIEW_TAG;
            viewAboveNavigationBar.backgroundColor = navigationBackgroundColor;
            
            controller.navigationController!.view.addSubview(viewAboveNavigationBar);
            
        }else{
            
            childController.view.frame = CGRect(x: 0, y: -90, width: childController.view.frame.size.width, height: childController.view.frame.size.height);
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                
                childController.view.frame = CGRect(x: 0, y: 0, width: childController.view.frame.size.width, height: childController.view.frame.size.height);
                
            });
        }
        
        childController.view.frame = (AppUtils.APPDELEGATE().window?.frame)!;
        controller.view.addSubview(childController.view);
        controller.addChildViewController(childController);
        childController.didMove(toParentViewController: controller);
        
    }
    
    static func removeChildViewController(_ controller : UIViewController, isViewAddedOnNavigationBar : Bool){
        
        if(isViewAddedOnNavigationBar){
            
            let viewAboveNavigationBar : UIView = (controller.navigationController?.view.viewWithTag(111))!;
            viewAboveNavigationBar.removeFromSuperview();
        }
        
        controller.navigationController?.isNavigationBarHidden = false;
        controller.willMove(toParentViewController: nil); // 1
        controller.view.removeFromSuperview(); // 2
        controller.removeFromParentViewController();
        
    }
    
    static func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    
//    static func CalculateHours (minute : Int) -> (Int, Int) {
//        return (minute * 60, (minute / 3600))
//    }
    
    static func getCharectoresFromString (fullName : String) -> String {
        let fullNameArr = fullName.characters.split{$0 == " "}.map(String.init)
        let firstLetters = fullNameArr.map { String($0.characters.first!) }
        
        // or simply:
        // let fullNameArr = fullName.characters.split{" "}.map(String.init)
        
        let fName = firstLetters[0] as String; // First
        var lName:String = "";
        if fullNameArr.count > 1{
            lName = firstLetters[1] as String;
        }
        return (fName + lName).uppercased();
    }
    
    
    static func FirebaseImageToUIimage(strURl:String) -> UIImage{
        var image:UIImage = UIImage()
        let fileUrl = Foundation.URL(string: strURl)
        if let data = NSData(contentsOf: fileUrl!) {
            image = UIImage(data: data as Data)!
        }
        return image
    }


    
    
    //MARK: - Add and Remove child controller
    static func addChildViewController(childController : UIViewController, controller : UIViewController, needToHideNavigationBar : Bool){
        
        if(needToHideNavigationBar){
            
            let viewAboveNavigationBar : UIView = UIView();
            viewAboveNavigationBar.frame = CGRect(x: 0, y: 0, width: (controller.navigationController?.navigationBar.frame.size.width)!, height: 64)
            viewAboveNavigationBar.tag = Constant.POPUP_NAVIGATIONBAR_VIEW_TAG;
            viewAboveNavigationBar.backgroundColor = Constant.POPUP_BACKGROUND_COLOR;
            
            controller.navigationController!.view.addSubview(viewAboveNavigationBar);
            
        }else{
            
            childController.view.frame = CGRect(x: 0, y: -90, width: childController.view.frame.size.width, height: childController.view.frame.size.height);
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                
                childController.view.frame = CGRect(x: 0, y: 0, width: childController.view.frame.size.width, height: childController.view.frame.size.height);
                
            });
        }
        
        childController.view.frame = (AppUtils.APPDELEGATE().window?.frame)!;
        childController.view.frame.size.height = childController.view.frame.size.height - 64;
        childController.view.tag = 19471950;
        controller.view.addSubview(childController.view);
        controller.addChildViewController(childController);
        childController.didMove(toParentViewController: controller);
        
    }
    
    static func removeChildViewController(controller : UIViewController, isViewAddedOnNavigationBar : Bool){
        
        if(isViewAddedOnNavigationBar){
            
            let viewAboveNavigationBar : UIView = (controller.navigationController?.view.viewWithTag(Constant.POPUP_NAVIGATIONBAR_VIEW_TAG))!;
            //        print(" remove View test:\(viewAboveNavigationBar)");
            viewAboveNavigationBar.removeFromSuperview();
        }
        
        controller.navigationController?.isNavigationBarHidden = false;
        controller.willMove(toParentViewController: nil); // 1
        controller.view.removeFromSuperview(); // 2
        controller.removeFromParentViewController();
        
    }
    
    
    //For hexa color
    
    
    static func HexToColor(hexString: String, alpha:CGFloat? = 1.0) -> UIColor {
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha!
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    static func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = NSCharacterSet(charactersIn: "#") as CharacterSet
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }


    
    
}
