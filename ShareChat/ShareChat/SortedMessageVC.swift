//
//  SortedMessageVC.swift
//  ShareChat
//
//  Created by Hiren-PC on 21/04/17.
//  Copyright © 2017 com.suflamtech. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Firebase

class SortedMessageVC: SuperViewController,UITableViewDelegate,UITableViewDataSource,GADBannerViewDelegate {

    @IBOutlet weak var tblSortMessages: UITableView!
    
    var arrSortMessages:NSMutableArray = NSMutableArray()
    var pageLimit:Int = 10;
    var pageIndex: NSInteger = 1;
    var paginEnabled : Bool = true;
    var strTag:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
         menuNavigationBarItem()
        goBackWithStringNavigationBarItem()
        self.navigationController?.navigationItem.title = strTag
        
        getSortMessages()
        tblSortMessages.delegate = self
        tblSortMessages.dataSource = self
        
        
        tblSortMessages.tableFooterView = UIView()
        tblSortMessages.separatorStyle = .none
        tblSortMessages.allowsSelection = false
        
        tblSortMessages.estimatedRowHeight = 300.0;
        tblSortMessages.rowHeight = UITableViewAutomaticDimension;
        tblSortMessages.layer.backgroundColor = UIColor.lightGray.cgColor
        print(strTag)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
         navigationItem.title = strTag
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Mark: Tableview Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSortMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row % 5 == 0{
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "sortaddcell", for: indexPath) as! AddSortMessageCell
            cell1.addSortView.adUnitID = "ca-app-pub-9733347540588953/7805958028"//ca-app-pub-3940256099942544/2934735716
            cell1.addSortView.rootViewController = self
            cell1.addSortView.delegate = self
            cell1.addSortView.load(GADRequest())
            //ca-app-pub-3940256099942544/4411468910"
            
            return cell1
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sortmessage", for: indexPath) as! SortMessageCell
        
        if let _ = arrSortMessages.object(at: indexPath.row) as? NSDictionary {
            
            cell.sortView.layer.cornerRadius = 10;
            cell.contentView.layer.backgroundColor = Constant.CELL_BACKGROUND_COLOUR.cgColor
            if (indexPath.row == self.arrSortMessages.count - 1) && (self.arrSortMessages.count % pageLimit == 0 && self.paginEnabled) {
                pageLimit += Constant.LIMIT_PAGINATION;
                getSortMessages()
            }
            //label tag
            
            cell.lblTag.text = ((arrSortMessages.object(at: indexPath.row) as AnyObject).value(forKey: "tag") as? String)!
            cell.lblTag.font = UIFont(name: Constant.TAG_TEXT_FONT, size: 10.0)
            cell.lblTag.textColor = Constant.TAG_TEXT_COLOR
            cell.lblTag.font = cell.lblTag.font.withSize(11)
            
            
            let strHexaColor:String = ((arrSortMessages.object(at: indexPath.row) as AnyObject).value(forKey: "tagcolor") as? String)!
            cell.lblTag.backgroundColor = AppUtils.HexToColor(hexString: strHexaColor)
            cell.lblTag.layer.cornerRadius = 10.0
            cell.lblTag.clipsToBounds = true
            cell.lblTag.textAlignment = .center
            
            //let index = strMessage.index(strMessage.startIndex, offsetBy: 10)
            //let strDate:String = strMessage.substring(to: index)
            //print(strDate)
            
            //label date
            let strDate:String = ((arrSortMessages.object(at: indexPath.row) as AnyObject).value(forKey: "date") as? String)!
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = dateFormatter.date(from: strDate)!
            cell.lblDate.text = DateUtils.getMonthAndYear(date) as String
            cell.lblDate.textColor = Constant.DATE_TEXT_COLOR
            cell.lblDate.font = UIFont(name: Constant.DATE_TEXT_FONT, size: 12.0)
            cell.lblDate.clipsToBounds = true
            cell.lblDate.font = cell.lblDate.font.withSize(13)
            
            //Message label
            cell.lblMessage.text = ((arrSortMessages.object(at: indexPath.row) as AnyObject).value(forKey: "message") as? String)
            cell.lblMessage.textColor = Constant.MESSAGE_TEXT_COLOR
            cell.lblMessage.font = UIFont(name: Constant.MESSAGE_TEXT_FONT, size: 15.0)
            cell.lblMessage.font = cell.lblMessage.font.withSize(15)
            
            //complaint button
            cell.btnComplaint.tag = indexPath.row
            cell.btnComplaint.titleLabel?.textColor = Constant.COMPLAINT_BUTTON_TEXT_COLOR
            cell.btnComplaint.titleLabel?.font = UIFont(name: Constant.COMPLAINT_BUTTON_FONT, size: 15.0)
            cell.btnComplaint.addTarget(self, action: #selector(DashBoardVC.btnComplaintTapped), for: .touchUpInside)
            cell.btnComplaint.titleLabel?.font = cell.btnComplaint.titleLabel?.font.withSize(13)
            
            //whatsapp button
            cell.btnWhatsApp.tag = indexPath.row
            cell.btnWhatsApp.titleLabel?.textColor = Constant.WHATSAPP_BUTTON_TEXT_COLOR
            cell.btnWhatsApp.titleLabel?.font = UIFont(name: Constant.WHATSAPP_BUTTON_FONT, size: 15.0)
            cell.btnWhatsApp.addTarget(self, action: #selector(DashBoardVC.btnWhatsAppTapped
                ), for: .touchUpInside)
            cell.btnWhatsApp.titleLabel?.font = cell.btnWhatsApp.titleLabel?.font.withSize(13)
            
            
            //Share button
            cell.btnShare.tag = indexPath.row
            cell.btnShare.titleLabel?.textColor = Constant.SHARE_BUTTON_TEXT_COLOR
            cell.btnShare.titleLabel?.font = UIFont(name: Constant.SHARE_BUTTON_FONT, size: 18.0)
            cell.btnShare.titleLabel?.textColor = Constant.SHARE_BUTTON_TEXT_COLOR
            cell.btnShare.titleLabel?.font = UIFont(name: Constant.SHARE_BUTTON_FONT, size: 18.0)
            cell.btnShare.addTarget(self, action: #selector(DashBoardVC.btnShareTapped), for: .touchUpInside)
            
            cell.btnShare.titleLabel?.font = cell.btnShare.titleLabel?.font.withSize(13)
            
            
        }
        return cell
    }
    
    
    func getSortMessages(){
        AppUtils.startLoading(self.view)
        FIRDatabase.database().reference().child("textmessages").queryOrdered(byChild: "tag").queryEqual(toValue: strTag).queryLimited(toFirst: UInt(pageLimit)).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                
                self.arrSortMessages.removeAllObjects()
                let postdata = snapshot.value as! NSMutableArray;
                //self.arrSortMessages = postdata as! NSMutableArray;
                for arr in postdata {
                    if let _ = arr as? NSDictionary {
                        self.arrSortMessages.add(arr);
                    }
                }

                if self.arrSortMessages.count < self.pageLimit{
                    self.paginEnabled = false
                }
                self.tblSortMessages.reloadData()
            
            }else{
                self.paginEnabled = false;
                print("No Messgae found");
            }
            AppUtils.stopLoading()
        });
    }

}
