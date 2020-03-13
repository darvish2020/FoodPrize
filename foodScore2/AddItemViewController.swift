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
class AddItemViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet var itemText: UITextField!
    @IBOutlet var priceText: UITextField!
    @IBOutlet var prizeView: FloatRatingView!
    @IBOutlet var itemPicture: UIImageView!
    @IBOutlet var albumButton: UIButton!
    @IBOutlet var cameraButton: UIButton!
    var item:String = ""
    var price:Int = 0
    var prize:Int = 0
    var placeId:String = ""
    var isUpdate:Bool = false
    var photoName:String = ""
    var Serial = 0
    var placeKey:String = ""
    var createDate = Date()
    var delegate:detailTableViewDelegate?
    let imagePicker = UIImagePickerController()
    var image:(Any)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *){
        }else{
            albumButton.setTitle("album", for: .normal)
            albumButton.setImage(nil, for: .disabled)
            cameraButton.setTitle("camera", for: .normal)
            cameraButton.setImage(nil, for: .disabled)
        }
        imagePicker.delegate = self
        if isUpdate{
            itemText.text = item
            priceText.text = String(price)
            prizeView.rating = Double(prize)
            //MARK:// createDate
        }else{
            prizeView.rating = 0.0
        }
        
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory, in:
            .userDomainMask)
        let docUrl = docUrls.first
        
        let url1 = docUrl?.appendingPathComponent(photoName)
        itemPicture.image = UIImage(contentsOfFile: (url1?.path)!)
        print(url1?.path)
    }
    
    
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        delegate?.backToDetil(placeId: placeId)
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func save(_ sender: UIBarButtonItem) {
        var savePhotoName = ""
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
            saveItem.photo = photoName
            try! realM.write{
                realM.add(saveItem, update: .modified)
                
            }
            view.dodo.style.bar.locationTop = false
            view.dodo.style.bar.hideAfterDelaySeconds = 2
            view.dodo.bottomAnchor = bottomLayoutGuide.topAnchor
            view.dodo.success("修改成功")
            
            //統一照片名稱存入app內
            savePhotoName = photoName
        }else{
            var savePlacekey = placeId + String(Serial)
            saveItem.placeKey = savePlacekey
            saveItem.photo = savePlacekey
            try! realM.write{
                realM.add(saveItem)
            }
            
            view.dodo.style.bar.locationTop = false
            view.dodo.style.bar.hideAfterDelaySeconds = 2
            view.dodo.bottomAnchor = bottomLayoutGuide.topAnchor
            view.dodo.success("儲存成功")
            savePhotoName = savePlacekey
            
            itemText.text = ""
            priceText.text = ""
            prizeView.rating = 0.0
            Serial += 1
            itemPicture.image = nil
        }
        
        if image != nil{
            let fileManager = FileManager.default
            let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
            let docUrl = docUrls.first
            let interval = Date.timeIntervalSinceReferenceDate
            
            let url = docUrl?.appendingPathComponent(savePhotoName)
            //把圖片存在APP裡
            let data = (image as! UIImage).jpegData(compressionQuality: 0.9)
            try! data?.write(to: url!)
        }

        
        
    }
    @IBAction func albumPress(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker,animated: true,completion: nil)
    }
    @IBAction func camreaPress(_ sender: UIButton) {
        imagePicker.sourceType = .camera
        self.present(imagePicker,animated: true,completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        image = info[.originalImage]
        self.itemPicture.image = image as! UIImage
        imagePicker.dismiss(animated: true, completion: nil)
    }
}


