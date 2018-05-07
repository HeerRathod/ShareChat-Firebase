//
//  SuperViewController.swift
//  BaseProjectSwift
//
//  Created by Sufalam5 on 12/30/15.
//  Copyright © 2015 Sufalam Technologies. All rights reserved.
//

import UIKit
import Firebase

class SuperViewController: UIViewController {

    
//    var sliderMenu : CustomerSliderView = CustomerSliderView.getCustomSliderMenus();
    var Name:String = ""
    
    var ref:FIRDatabaseReference?
    var DatabaseHandle: FIRDatabaseHandle?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.barTintColor = Constant.NAVIGATION_BAR_COLOR;
        
        
//        self.navigationController?.navigationBar.barTintColor = UIColor(red: 212.0/255.0, green: 254.0/255.0, blue: 88.0/255.0, alpha: 1.0)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        
        self.view.endEditing(true);
    }
    
    
    func NavigationBarTitle(){
        let image = UIImage(named: "NavLogo")
        self.navigationItem.titleView = UIImageView(image: image)
    }
    
    func action(){
        print("hello")
    }


    //MARK: - Set navigation GoBack button
    
    func goBackNavigationBarItem(){
        //Left Button - Navigation bar
        let imgName: String = "GoBackArrow";
        let leftButton = UIBarButtonItem(image: UIImage(named: imgName)?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(SuperViewController.btnBackClicked(_:)))
        
        self.navigationItem.leftBarButtonItem = leftButton;
    }

    
    func goBackWithStringNavigationBarItem(){
        //Left Button - Navigation bar
        let imgName: String = "BackButtton";
        let leftButton = UIBarButtonItem(image: UIImage(named: imgName)?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(SuperViewController.btnBackClicked(_:)))
        
        self.navigationItem.setLeftBarButton(leftButton, animated: true);
    }
    
    func btnBackClicked(_ sender:UIButton!){
        self.navigationController!.popViewController(animated: true);
    }
    
    //MARK: - Set navigation GoBack button
    func logOutNavigationBarItem(){
        //Left Button - Navigation bar
        let imgName: String = "Logout";
        let leftButton = UIBarButtonItem(image: UIImage(named: imgName)?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(SuperViewController.btnLogOutClicked(_:)))
        self.navigationItem.leftBarButtonItem = leftButton;
    }
    
    func btnLogOutClicked(_ sender:UIButton!){
        self.navigationController!.popToRootViewController(animated: true);
    }
    
    //Set navigation Menu button
    func menuNavigationBarItem(){
        //Left Button - Navigation bar
        let imgName: String = "Menu";
        let leftButton = UIBarButtonItem(image: UIImage(named: imgName)?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(SuperViewController.btnMenuClicked(_:)))
        
        
        let Name1 = UIBarButtonItem(title: Name.uppercased(), style: .plain, target: self, action: nil)
        //set bar button colour
        let customFont = UIFont(name: Constant.FONT_BEBASNEUE, size: 17.0)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: customFont!], for: UIControlState.normal)
        Name1.tintColor = UIColor(red: 212.0/255.0, green: 254.0/255.0, blue: 88.0/255.0, alpha: 1.0)
        
        self.navigationItem.setLeftBarButtonItems([leftButton,Name1], animated: true);
    }
    
    //Set navigation Menu button
    func SetRightBarbutton(){
        let btn1 = UIButton()
        btn1.layer.cornerRadius = 15
        btn1.clipsToBounds = true
        
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(SuperViewController.action1), for: .touchUpInside)
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: btn1), animated: true);
    }
    
    func action1(){
        print("button Tapped")
    }
    
//    func action1(){
//        let objMyprofile = self.storyboard?.instantiateViewController(withIdentifier: "MyProfile") as! MyProfile
//        self.navigationController?.pushViewController(objMyprofile, animated: true);
//    }
    
    
    
    func btnMenuClicked(_ sender:UIButton!){
//        self.view.endEditing(true);
//        self.navigationController!.navigationBar.endEditing(true);
//        self.view.isUserInteractionEnabled = false;
//        NSLog("Menu clicked");
//        sliderMenu.setMenuswithArray(self,width: 0.0);
    }
    
}
