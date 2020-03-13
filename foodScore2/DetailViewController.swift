//
//  DetailViewController.swift
//  foodScore2
//
//  Created by Tsai Meng Han on 2020/2/18.
//  Copyright © 2020 Tsai Meng Han. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,detailTableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet var detailTableView: UITableView!
    @IBOutlet var placePicture: UIImageView!
    var loadItems:Results<placeItemBO>?
    var totalCount = 0
    //@IBOutlet var nav: UINavigationBar!
    var placeID:String = ""
    var name:String = ""
    var itemArray = [String]()
    var priceArray = [Int]()
    var prizeArray = [Int]()
    var createDate = [Date]()
    var serialArray = [Int]()
    var placekeyArray = [String]()
    var photoPlaceArray = [String]()
    var photoArray = [String]()
    var hasPlacePitcure:Bool = false
    let imagePicker = UIImagePickerController()
    @IBOutlet var nameLabel: UILabel!
    override func viewDidLoad() {
        
//        if #available(iOS 13.0, *) {
//            nav.isHidden = true
//        }
        
        super.viewDidLoad()
        self.imagePicker.delegate = self
        //給商家名稱
        nameLabel.text = name
        //loadData
        loadDataFromRealM()
    }
    
    
    @IBAction func itemPriceInsert(_ sender: UIButton) {
        
        
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "item") as! AddItemViewController
        controller.isUpdate = false
        controller.placeId = placeID
        controller.Serial = (serialArray.last ?? 0) + 1
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
        
        
    }

    @IBAction func albumPress(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker,animated: true,completion: nil)
    }
    
    @IBAction func cameraPress(_ sender: UIButton) {
        imagePicker.sourceType = .camera
         self.present(imagePicker,animated: true,completion: nil)
    }
    @IBAction func backToMap(_ sender: UIBarButtonItem) {
        
        let mapController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "map")
        present(mapController, animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //如果serial 有含店家照片 就要減一
        var count = totalCount
        if hasPlacePitcure{
            count -= 1
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemTableViewCell
        cell.item.text = itemArray[indexPath.row]
        cell.price.text = "$" + String(priceArray[indexPath.row])
        //cell.prizeImage.image = UIImage(named: "chickenatteck")
        cell.prizeView.rating = Double(prizeArray[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "item") as! AddItemViewController
        controller.isUpdate = true
        controller.item = itemArray[indexPath.row]
        controller.price = priceArray[indexPath.row]
        controller.prize = prizeArray[indexPath.row]
        controller.placeId = placeID
        controller.Serial = serialArray[indexPath.row]
        controller.placeKey = placekeyArray[indexPath.row]
        controller.photoName = photoArray[indexPath.row]
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    func loadDataFromRealM(){
        let realM = try! Realm()
        loadItems = realM.objects(placeItemBO.self).filter("placeID = '\(placeID)'")
        if let loadData = loadItems{

            totalCount = loadData.count
            
            itemArray.removeAll()
            priceArray.removeAll()
            prizeArray.removeAll()
            serialArray.removeAll()
            placekeyArray.removeAll()
            photoPlaceArray.removeAll()
            photoArray.removeAll()
            hasPlacePitcure = false
            //排除店家照片的row
            for result in loadData.filter("serial <> 0"){
                itemArray.append(result.item)
                priceArray.append(result.price)
                prizeArray.append(result.prize)
                serialArray.append(result.serial)
                placekeyArray.append(result.placeKey)
                photoArray.append(result.photo)
                
            }
            //取得店家row的資料
            for photoResult in loadData.filter("serial = 0"){
                photoPlaceArray.append(photoResult.photo)
                break
            }
        }
        
        //取店家照片
        if photoPlaceArray.count > 0{
            hasPlacePitcure = true
            
            let fileManager = FileManager.default
            let docUrls = fileManager.urls(for: .documentDirectory, in:
                    .userDomainMask)
            let docUrl = docUrls.first
            let photoName = photoPlaceArray[0]
            let url1 = docUrl?.appendingPathComponent(photoName)
            placePicture.image = UIImage(contentsOfFile: (url1?.path)!)
                print(url1?.path)
        }

        
        
        
    }
    
    func backToDetil(placeId: String) {
        placeID = placeId
        //重新讀取資料
         loadDataFromRealM()
        detailTableView.reloadData()
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                //選取照片顯示在image上
        let image = info[.originalImage]
        self.placePicture.image = image as! UIImage
        
        let realM = try! Realm()
        let saveItem:placeItemBO = placeItemBO()
        //店家照片固定放在serial=0
        let photo = placeID + "0"
        saveItem.placeID = placeID
        saveItem.item = ""
        saveItem.price = 0
        saveItem.prize = 0
        saveItem.serial = 0
        saveItem.photo = photo
        saveItem.placeKey = placeID + "0"
                  try! realM.write{
                      realM.add(saveItem, update: .modified)
                  }
        
        
        //取得路徑
           let fileManager = FileManager.default
           let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
           let docUrl = docUrls.first
           let interval = Date.timeIntervalSinceReferenceDate
           
        let url = docUrl?.appendingPathComponent(photo)
        //把圖片存在APP裡
        let data = (image as! UIImage).jpegData(compressionQuality: 0.9)
           try! data?.write(to: url!)
        
        
        picker.dismiss(animated: true, completion: nil)
    }

}

