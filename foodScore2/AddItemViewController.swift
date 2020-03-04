//
//  AddItemViewController.swift
//  foodScore2
//
//  Created by Tsai Meng Han on 2020/2/26.
//  Copyright © 2020 Tsai Meng Han. All rights reserved.
//

import UIKit
import RealmSwift
protocol detailTableViewDelegate {
    func backToDetil(placeId:String)
}
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
    var delegate:detailTableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isUpdate{
            itemText.text = item
            priceText.text = String(price)
            prizeText.text = String(prize)
        }
    }
    



    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        delegate?.backToDetil(placeId: placeId)
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func save(_ sender: UIBarButtonItem) {
        let methodutils = MethodUtil()
        var warningStr:String = ""
        if !(methodutils.isNotEmpty(Str: itemText.text)){
//            let alert = UIAlertController(title: "警告", message: "請輸入品項", preferredStyle: .alert)
//            let OKbutton = UIAlertAction(title: "OK", style: .default, handler: nil)
//            alert.addAction(OKbutton)
//            present(alert,animated: true,completion: nil)
//            return
            warningStr += "請輸入品項,"
        }
        if !(methodutils.isNumber(str: priceText.text)){
            warningStr += "價格需為數字,"
        }
        
        if  !(methodutils.isNumber(str: prizeText.text)){
            warningStr += "評價須為數字,"
        }
        
        if warningStr.count > 0{
            //let index = warningStr.index(warningStr.endIndex, offsetBy: -1)
            warningStr = String(warningStr.prefix(warningStr.count - 1))
            let alert = UIAlertController(title: "警告", message: warningStr, preferredStyle: .alert)
            let OKbutton = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(OKbutton)
            present(alert,animated: true,completion: nil)
            return
        }
        
            if isUpdate{
                
            }else{
                let realM = try! Realm()
                let saveItem:placeItemBO = placeItemBO()
                saveItem.placeID = placeId
                saveItem.item = itemText.text!
                saveItem.price = Int(priceText.text!)!
                saveItem.prize = Int(prizeText.text!)!
                saveItem.serial = Serial
                try! realM.write{
                    realM.add(saveItem)
                }
            }
            
            

    }
}


