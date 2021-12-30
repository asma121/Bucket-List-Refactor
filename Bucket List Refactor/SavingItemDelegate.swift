//
//  savingItemDelegate.swift
//  Bucket List Refactor
//
//  Created by admin on 15/12/2021.
//

import Foundation

protocol SavingItemDelegate : AnyObject {
    func saveItem( controller : ViewController , itemText: String , itemIndex:NSIndexPath?)
}
