//
//  AddItemViewController.swift
//  foodScore2
//
//  Created by Tsai Meng Han on 2020/2/26.
//  Copyright © 2020 Tsai Meng Han. All rights reserved.
//

import UIKit
import RealmSwift
import Dodo
import FloatRatingView
protocol detailTableViewDelegate {
    func backToDetil(placeId:String)
}
class AddItemViewController: UIViewController {
    
    
    @IBOutlet var itemText: UITextField!
    @IBOutlet var priceText: UITextField!
    @IBOutlet var prizeView: FloatRatingView!
    var item:String = ""
    var price:Int = 0
    var prize:Int = 0
    var placeId:String = ""
    var isUpdate:Bool = false
    var Serial = 0
    var placeKey:String = ""
    var delegate:detailTableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isUpdate{
            itemText.text = item
            priceText.text = String(price)
            prizeView.rating = Double(prize)
        }else{
            prizeView.rating = 0.0
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
            warningStr += "請輸入品項,"
        }
        if !(methodutils.isNumber(str: priceText.text)){
            warningStr += "價格需為數字,"
        }
        
        if warningStr.count > 0{
            warningStr = String(warningStr.prefix(warningStr.count - 1))
            let alert = UIAlertController(title: "警告", message: warningStr, preferredStyle: .alert)
            let OKbutton = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(OKbutton)
            present(alert,animated: true,completion: nil)
            return
        }
        let realM = try! Realm()
        let saveItem:placeItemBO = placeItemBO()
        saveItem.placeID = placeId
        saveItem.item = itemText.text!
        saveItem.price = Int(priceText.text!)!
        saveItem.prize = Int(self.prizeView.rating)
        saveItem.serial = Serial
        
        if isUpdate{
            saveItem.placeKey = placeKey
            try! realM.write{
                realM.add(saveItem, update: .modified)
                
            }
            view.dodo.style.bar.locationTop = false
            view.dodo.style.bar.hideAfterDelaySeconds = 2
            view.dodo.bottomAnchor = bottomLayoutGuide.topAnchor
            view.dodo.success("修改成功")
        }else{
            var savePlacekey = placeId + String(Serial)
            saveItem.placeKey = savePlacekey
            try! realM.write{
                realM.add(saveItem)
            }
            //MARK: 失敗的顯示方式？！
            view.dodo.style.bar.locationTop = false
            view.dodo.style.bar.hideAfterDelaySeconds = 2
            view.dodo.bottomAnchor = bottomLayoutGuide.topAnchor
            view.dodo.success("儲存成功")
            
            itemText.text = ""
            priceText.text = ""
            prizeView.rating = 0.0
            Serial += 1
        }

        
    }
}


