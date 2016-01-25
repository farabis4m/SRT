//
//  String+Helpers.swift
//
//  Created by Alex Zdorovets on 6/17/15.
//  Copyright (c) 2015 Alex Zdorovets. All rights reserved.
//

import Foundation

extension String {
    public static var applicationDocumentsDirectory : String {
        get {
            let nsDocumentDirectory = NSSearchPathDirectory.DocumentDirectory
            let nsUserDomainMask = NSSearchPathDomainMask.UserDomainMask
            return NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true).first!
        }
    }
    
    public var capitalizedFirstString : String {
        get {
            let index: String.Index = self.startIndex.advancedBy(1)
            let firstCapChar = self.substringToIndex(index).capitalizedString
            return (self.lowercaseString as NSString).stringByReplacingCharactersInRange(NSMakeRange(0,1), withString: firstCapChar)
        }
    }
    
    public var toDictionary : Dictionary<String,AnyObject>? {
        get {
            guard let data = (self as NSString).dataUsingEncoding(NSUTF8StringEncoding) else {
                return nil
            }
            do {
                return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? Dictionary<String, AnyObject>
            } catch {
                return nil
            }
        }
    }
    
    public func stringToDate(mask:String) -> NSDate? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = mask
        return dateFormatter.dateFromString(self)
    }
    
    public func trunc(length: Int, trailing: String? = "...") -> String {
        if self.characters.count > length {
            return self.substringToIndex(self.startIndex.advancedBy(length)) + (trailing ?? "")
        } else {
            return self
        }
    }
}