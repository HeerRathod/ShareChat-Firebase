//
//  ComplainVC.swift
//  ShareChat
//
//  Created by Hiren-PC on 14/04/17.
//  Copyright © 2017 com.suflamtech. All rights reserved.

import UIKit
import Firebase

class ComplainVC: SuperViewController,UITextViewDelegate {
    
    
    @IBOutlet weak var popView: UIView!
    
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    
    
    var strComplaint:String = "";
    var strMessage:String = "";
    var strKey:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtEmail.layer.borderWidth = 1.0
        txtEmail.layer.borderColor = UIColor.darkGray.cgColor
        
        textview.layer.borderWidth = 1.0
        textview.layer.borderColor = UIColor.darkGray.cgColor
        textview.delegate = self
        
        popView.layer.cornerRadius = 10.0;
        
        btnSubmit.layer.backgroundColor = Constant.SUBMIT_BUTTON_BACKGROUND_COLOR.cgColor
        btnSubmit.titleLabel?.textColor = Constant.SUBMIT_BUTTON_TEXT_COLOR
        btnSubmit.titleLabel?.font = UIFont(name: Constant.SUBMIT_BUTTON_FONT, size: 12.0)
        
        lblMessage.text = strMessage
        CheckIndexOfData()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnCancelTapped(_ sender: UIButton) {
        AppUtils.removeChildViewController(controller: self,isViewAddedOnNavigationBar: true);
    }
    
    @IBAction func btnSubmitTapped(_ sender: UIButton) {
        if (AppUtils.validateEmail(txtEmail.text!) != true) && (txtEmail.text != ""){
            AppUtils.showAlertWithTitle("Alert", message: "Please enter Valid email address")
        }else if strComplaint == ""{
            AppUtils.showAlertWithTitle("Alert", message: "Please insert Comments")
        }else{
            AddComplain();
        }
    }
    
    //MARK:Textview delegate methods
    func textViewDidEndEditing(_ textView: UITextView) {
        strComplaint = textview.text
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func CheckIndexOfData(){
        AppUtils.startLoading(self.view)
        FIRDatabase.database().reference().child("textmessages").queryOrdered(byChild: "message").queryEqual(toValue: strMessage).observeSingleEvent(of: .childAdded, with: { (snapshot) in
            if snapshot.exists() {
                self.strKey = snapshot.key
               print(self.strKey)
            AppUtils.stopLoading()
            }
        });
    }
    
    
    func AddComplain(){
        AppUtils.startLoading(self.view)
        let arrComplaint:NSMutableDictionary = NSMutableDictionary()
        ref = FIRDatabase.database().reference().child("complaint").child(strKey).childByAutoId().child("complainText");
        arrComplaint.setValue(strComplaint, forKey: "complaint")
        arrComplaint.setValue(self.txtEmail.text, forKey: "email")
        
        ref?.setValue(arrComplaint);
        let refreshAlert = UIAlertController(title: "Success", message: "your complaint added successfully", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            AppUtils.removeChildViewController(controller: self,isViewAddedOnNavigationBar: true);
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
        AppUtils.stopLoading()
    }

}
