//
//  DateUtils.swift
//  project
//
//  Created by Sufalam5 on 11/18/15.
//  Copyright © 2015 Sufalam 4. All rights reserved.
//

import Foundation

class DateUtils:NSObject {
    
    
    static func getTimeToDisplay(_ sourceDate:Date,hourFormat12:Bool) -> NSString{
        
        print("Date is:\(sourceDate)");
        let unitFlags: NSCalendar.Unit = [.day, .weekOfYear, .month, .year, .hour, .minute, .second];
        
        let now = Date();
        let calendar = Calendar(identifier: Calendar.Identifier.indian);
        var components1 = (calendar as NSCalendar).components(unitFlags, from: now);
        
        components1.hour = 23;
        components1.minute = 59;
        components1.second = 59;
        
        var dateToday = calendar.date(from: components1);
        
        var components = (calendar as NSCalendar).components(unitFlags, from: sourceDate, to: dateToday!, options: NSCalendar.Options(rawValue: 0));
        
        let formatSourceDate = DateFormatter();
        
        formatSourceDate.amSymbol = "AM";
        formatSourceDate.pmSymbol = "PM";
        
        var timestamp = "";
//        print("Components:\(components)");
        if (components.year! > 0 || components.month! > 0 || components.weekOfYear! > 0) {
            
            formatSourceDate.dateFormat = "MMM dd, yyyy";
            
            timestamp = formatSourceDate.string(from: sourceDate);
            return timestamp as NSString;
            
        } else if (components.day! > 0) {
            
            if (components.day! > 1) {
                
                formatSourceDate.dateFormat = "EEEE";
                timestamp = formatSourceDate.string(from: sourceDate);
                return timestamp as NSString;
                
            } else {
                return "Yesterday";
            }
        }
        

        components1 = (calendar as NSCalendar).components(unitFlags, from: Date());
        dateToday = calendar.date(from: components1);
        components = (calendar as NSCalendar).components(unitFlags, from: sourceDate, to: dateToday!, options: NSCalendar.Options(rawValue: 0));
//        print("Components:\(components)");
        
        if(components.hour! > 0){
            
            if(hourFormat12){
                
                formatSourceDate.dateFormat = "hh:mm a";
            }else{
                
                formatSourceDate.dateFormat = "HH:mm";
            }
            timestamp = formatSourceDate.string(from: sourceDate);
            
            return timestamp as NSString;
            
        }else if(components.minute! > 0){
            
            
            timestamp = "\(components.minute) minutes ago";
            
            return timestamp as NSString;
            
        }else{
            
            timestamp = "\(components.second) seconds ago";
            
            return timestamp as NSString;
        }
        
        return timestamp as NSString;
        
    }
    
    //This method gives formatted date(as string) as given format
    static func getFormattedDate(_ sourceDate:Date,dateFormat:NSString) -> NSString{
        
//        print("Date is:\(sourceDate)");
        
        let formatSourceDate = DateFormatter();
        
        formatSourceDate.amSymbol = "AM";
        formatSourceDate.pmSymbol = "PM";
        
        var formattedDate = "";
        
        formatSourceDate.dateFormat = dateFormat as String;
        
        formattedDate = formatSourceDate.string(from: sourceDate);
        
        return formattedDate as NSString;
        
    }
    
    //This method gives formatted date(as string) by source format(input string) and destination format
    static func getFormattedDate(_ sourceString:NSString,sourceFormat:NSString,destinationFormat:NSString) -> NSString{
        
        let dateFormatter = DateFormatter();
        
        dateFormatter.dateFormat = sourceFormat as String;
        let sourceDate = dateFormatter.date(from: sourceString as String);
        
        dateFormatter.amSymbol = "AM";
        dateFormatter.pmSymbol = "PM";
        
        dateFormatter.dateFormat = destinationFormat as String;
        
        var formattedDate = "";
        formattedDate = dateFormatter.string(from: sourceDate!);
        
        return formattedDate as NSString;
        
    }
    
    static func getDateByAddingTimeInterval(_ sourceDate:Date,days:Double,hours:Double,minutes:Double,seconds:Double) -> Date{
        
        var interval = -60*60*24*days;
        interval -= 60 * 60 * hours;
        interval -= 60 * minutes;
        interval -= seconds;
        
        let tempDate = sourceDate.addingTimeInterval(interval);
        
        return tempDate;
        
    }
    
    static func getDateStringOrTodayString(_ sourceDate:Date)-> String {
        var stDate = "";
        let today:Bool = NSCalendar.current.isDateInToday(sourceDate)
        if today {
            stDate = "Today";
        }else{
            let formatSourceDate = DateFormatter();
            formatSourceDate.dateFormat = "dd";
            stDate = formatSourceDate.string(from: sourceDate);
         }
        return stDate;
    }
    
    static func getMonthAndYear(_ sourceDate:Date)-> String {
        let formatSourceDate = DateFormatter();
        formatSourceDate.dateFormat = "MMM,dd, yyyy";
        return formatSourceDate.string(from: sourceDate);
    }
    
}
