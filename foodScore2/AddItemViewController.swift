//
//  AddItemViewController.swift
//  foodScore2
//
//  Created by Tsai Meng Han on 2020/2/26.
//  Copyright © 2020 Tsai Meng Han. All rights reserved.
//

import UIKit
import RealmSwift
class AddItemViewController: UIViewController {


    @IBOutlet var itemText: UITextField!
    @IBOutlet var priceText: UITextField!
    @IBOutlet var prizeText: UITextField!
    var item:String = ""
    var price:Int = 0
    var prize:Int = 0
    var placeId:String = ""
    var isUpdate:Bool = false
    var Serial = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isUpdate{
            itemText.text = item
            priceText.text = String(price)
            prizeText.text = String(prize)
        }
    }
    



    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func save(_ sender: UIBarButtonItem) {
        //MARK: TODO 檢核
        let stringutils = StringUtil()
        if stringutils.isNotEmpty(Str: itemText.text){
            if isUpdate{
                
            }else{
                let realM = try! Realm()
                let saveItem:placeItemBO = placeItemBO()
                saveItem.placeID = placeId
                saveItem.item = itemText.text!
                saveItem.price = Int(priceText.text!)!
                saveItem.prize = Int(prizeText.text!)!
                saveItem.serial = Serial
                //        let saveItems :placeItemBO = placeItemBO()
                //        saveItems.placeID = placeID
                //        saveItems.item = "lottee"
                //        saveItems.price = 150
                //        saveItems.prize = 3
                //        saveItems.serial = 2
                //
                //        try! realMsave.write{
                //             realMsave.add(saveItems)
                //        }
            }
            
            //MARK: TODO 記得傳值回去
        }else{
            let alert = UIAlertController(title: "警告", message: "請輸入品項", preferredStyle: .alert)
            let OKbutton = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(OKbutton)
            present(alert,animated: true,completion: nil)
        }
    }
}
