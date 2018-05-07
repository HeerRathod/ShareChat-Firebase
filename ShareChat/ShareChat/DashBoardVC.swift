//
//  DashBoardVC.swift
//  ShareChat
//
//  Created by Hiren-PC on 12/04/17.
//  Copyright © 2017 com.suflamtech. All rights reserved.


import UIKit
import Firebase
import GoogleMobileAds

class DashBoardVC: SuperViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblDashBoard: UITableView!
    @IBOutlet weak var addView: GADBannerView!
    
    var Message:String = "";
    var pageLimit:Int = 10;
    var pageIndex: NSInteger = 1;
    var paginEnabled : Bool = true;
    var strTag:String = ""
    
    var arrMessgaes:NSMutableArray = NSMutableArray()
    var arrNewMessageDate:NSMutableArray = NSMutableArray()

    var indexValue:Int = 0;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuNavigationBarItem()
        
        tblDashBoard.delegate = self
        tblDashBoard.dataSource = self
        
        //Advertisements
        addView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        addView.rootViewController = self
        addView.load(GADRequest())
 
        tblDashBoard.tableFooterView = UIView()
        tblDashBoard.separatorStyle = .none
        tblDashBoard.allowsSelection = false
        
        tblDashBoard.estimatedRowHeight = 300.0;
        tblDashBoard.rowHeight = UITableViewAutomaticDimension;
        tblDashBoard.layer.backgroundColor = UIColor.lightGray.cgColor
        
        getAddIndex()
        getMessages()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Mark: tableview delegate methods
   
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if section == 0{
            if let headerView = view as? UITableViewHeaderFooterView, let textLabel = headerView.textLabel {
                
                headerView.textLabel?.textColor = UIColor.darkGray
                headerView.textLabel?.font = UIFont(name: Constant.SHARE_BUTTON_FONT, size: 18.0)
                headerView.textLabel?.textAlignment = .center
                headerView.backgroundColor = UIColor.darkGray
            }
        }
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0;
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            if(section == 0) {
                return "Best Messages"
            } else {
                return ""
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMessgaes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row % indexValue == 0{
            
            print(arrMessgaes.count % 10)
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "addcell", for: indexPath) as! AdvertiseCell
            
            cell1.addView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
            cell1.addView.rootViewController = self
            cell1.addView.load(GADRequest())
            
            return cell1
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "dashboardCell", for: indexPath) as! DashboardCell
            
            cell.cellView.layer.cornerRadius = 10;
            cell.contentView.layer.backgroundColor = Constant.CELL_BACKGROUND_COLOUR.cgColor
            if (indexPath.row == self.arrMessgaes.count - 1) && (self.arrMessgaes.count % pageLimit == 0 && self.paginEnabled) {
                pageLimit += Constant.LIMIT_PAGINATION;
                getMessages()
            }
            
            //label tag
            let tagTitle:String = ((arrMessgaes.object(at: indexPath.row) as AnyObject).value(forKey: "tag") as? String)!
            cell.btnTag.setTitle(tagTitle, for: .normal)
            cell.btnTag.tintColor = Constant.TAG_TEXT_COLOR
            cell.btnTag.titleLabel?.font = UIFont(name: Constant.TAG_TEXT_FONT, size: 10.0)
//            cell.btnTag.titleLabel?.textColor = Constant.TAG_TEXT_COLOR
            cell.btnTag.titleLabel?.font = cell.btnTag.titleLabel?.font.withSize(11)
            
            let strHexaColor:String = ((arrMessgaes.object(at: indexPath.row) as AnyObject).value(forKey: "tagcolor") as? String)!
            
            cell.btnTag.backgroundColor = AppUtils.HexToColor(hexString: strHexaColor)
            cell.btnTag.layer.cornerRadius = 10.0
            cell.btnTag.clipsToBounds = true
            cell.btnTag.titleLabel?.textAlignment = .center
            cell.btnTag.tag = indexPath.row
            cell.btnTag.addTarget(self, action: #selector(DashBoardVC.btnTagTapped), for: .touchUpInside)
            
            //let index = strMessage.index(strMessage.startIndex, offsetBy: 10)
            //let strDate:String = strMessage.substring(to: index)
            //print(strDate)
            
            //label date
            let strDate:String = ((arrMessgaes.object(at: indexPath.row) as AnyObject).value(forKey: "date") as? String)!
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = dateFormatter.date(from: strDate)!
            cell.lblDate.text = DateUtils.getMonthAndYear(date) as String
            cell.lblDate.textColor = Constant.DATE_TEXT_COLOR
            cell.lblDate.font = UIFont(name: Constant.DATE_TEXT_FONT, size: 12.0)
            cell.lblDate.clipsToBounds = true
            cell.lblDate.font = cell.lblDate.font.withSize(13)
            
            //Message label
            cell.lblmessage.text = ((arrMessgaes.object(at: indexPath.row) as AnyObject).value(forKey: "message") as? String)
            cell.lblmessage.textColor = Constant.MESSAGE_TEXT_COLOR
            cell.lblmessage.font = UIFont(name: Constant.MESSAGE_TEXT_FONT, size: 15.0)
            cell.lblDate.font = cell.lblDate.font.withSize(13)
            
            //complaint button
            cell.btnComplain.tag = indexPath.row
            cell.btnComplain.tintColor = Constant.COMPLAINT_BUTTON_TEXT_COLOR
            cell.btnComplain.titleLabel?.font = UIFont(name: Constant.COMPLAINT_BUTTON_FONT, size: 15.0)
            cell.btnComplain.addTarget(self, action: #selector(DashBoardVC.btnComplaintTapped), for: .touchUpInside)
             cell.btnComplain.titleLabel?.font = cell.btnComplain.titleLabel?.font.withSize(13)
            
            
            
            //whatsapp button
            cell.btnWhatsApp.tag = indexPath.row
            cell.btnWhatsApp.tintColor = Constant.WHATSAPP_BUTTON_TEXT_COLOR
            cell.btnWhatsApp.titleLabel?.font = UIFont(name: Constant.WHATSAPP_BUTTON_FONT, size: 15.0)
            cell.btnWhatsApp.addTarget(self, action: #selector(DashBoardVC.btnWhatsAppTapped
                ), for: .touchUpInside)
            cell.btnWhatsApp.titleLabel?.font = cell.btnWhatsApp.titleLabel?.font.withSize(13)
            
            
            //Share button
            cell.btnShare.tag = indexPath.row
            cell.btnShare.titleLabel?.font = UIFont(name: Constant.SHARE_BUTTON_FONT, size: 18.0)
            cell.btnShare.titleLabel?.textColor = Constant.SHARE_BUTTON_TEXT_COLOR
            cell.btnShare.titleLabel?.font = UIFont(name: Constant.SHARE_BUTTON_FONT, size: 18.0)
            cell.btnShare.addTarget(self, action: #selector(DashBoardVC.btnShareTapped), for: .touchUpInside)
            cell.btnShare.titleLabel?.font = cell.btnShare.titleLabel?.font.withSize(13)
            
    
            
            return cell
        }
    }
    
    
    func btnShareTapped(sender:UIButton){
        
        //Access data of particular cell without didselect method: Hiren Rathod
        let indexPath = NSIndexPath(row: sender.tag, section: 0);
        let cell = tblDashBoard.cellForRow(at: indexPath as IndexPath) as! DashboardCell
        Message = cell.lblmessage.text!
        
        // set up activity view controller
        let MessageToShare = [ Message ];
        let activityViewController = UIActivityViewController(activityItems: MessageToShare, applicationActivities: nil);
        activityViewController.popoverPresentationController?.sourceView = self.view; //
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop];//UIActivityType.postToFacebook
        activityViewController.completionWithItemsHandler = { (activity, success, items, error) in
            print(success ? "SUCCESS!" : "FAILURE");
            if success {
                print("share success")
            }
        }
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil);
    }
    
    
    func btnTagTapped(sender:UIButton){
        let indexPath = NSIndexPath(row: sender.tag, section: 0);
        let cell = tblDashBoard.cellForRow(at: indexPath as IndexPath) as! DashboardCell
        strTag = (cell.btnTag.titleLabel?.text)!
        
        let objSortMessage = self.storyboard?.instantiateViewController(withIdentifier: "SortedMessageVC") as! SortedMessageVC
        objSortMessage.strTag = strTag
        self.navigationController?.pushViewController(objSortMessage, animated: true)
    }
    
    
    
    func btnComplaintTapped(sender:UIButton){
         let indexPath = NSIndexPath(row: sender.tag, section: 0);
        let cell = tblDashBoard.cellForRow(at: indexPath as IndexPath) as! DashboardCell
        Message = cell.lblmessage.text!

        
        let childController: ComplainVC! = self.storyboard?.instantiateViewController(withIdentifier: "ComplainVC") as! ComplainVC;
        childController.strMessage = Message;
        AppUtils.addChildViewController(childController: childController, controller: self,needToHideNavigationBar: true);
    }
    
    
    func btnWhatsAppTapped(sender:UIButton){
        
        let indexPath = NSIndexPath(row: sender.tag, section: 0);
        let cell = tblDashBoard.cellForRow(at: indexPath as IndexPath) as! DashboardCell
        Message = cell.lblmessage.text!
        
        var strUrl : String = "whatsapp://send?text=\(Message)";
        strUrl = strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!;
        let whatsAppUrl = NSURL(string: strUrl );
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(whatsAppUrl! as URL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(whatsAppUrl! as URL)
        };
    }
    

    //MARK:Retrive all the messgae from firebase
    func getMessages(){
        AppUtils.startLoading(self.view)
        FIRDatabase.database().reference().child("textmessages").queryLimited(toFirst: UInt(pageLimit)).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
    
                self.arrMessgaes.removeAllObjects()
                let postdata = snapshot.value as! NSArray;
                self.arrMessgaes = postdata as! NSMutableArray;
//                let descriptor = NSSortDescriptor(key: "date", ascending: false)
//                self.arrMessgaes.sort(using: [descriptor])
    
                if self.arrMessgaes.count < self.pageLimit{
                    self.paginEnabled = false
                }
                self.tblDashBoard.reloadData()
                
                }else{
                self.paginEnabled = false;
                print("No Messgae found");
            }
            AppUtils.stopLoading()
        });
        
    }
    
    
    //MARK:Retrive all the messgae from firebase
    func getAddIndex(){
        FIRDatabase.database().reference().child("addindex").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                print(snapshot)
                let postData = snapshot.value as! NSDictionary
                print(postData)
                self.indexValue = postData.value(forKey: "index") as! Int
                print(self.indexValue)
            }
        });
        
    }
    
    
    
    

}
