//
//  DetailViewController.swift
//  foodScore2
//
//  Created by Tsai Meng Han on 2020/2/18.
//  Copyright © 2020 Tsai Meng Han. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,detailTableViewDelegate {

    
    @IBOutlet var detailTableView: UITableView!
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
    @IBOutlet var nameLabel: UILabel!
    override func viewDidLoad() {
        
//        if #available(iOS 13.0, *) {
//            nav.isHidden = true
//        }
        super.viewDidLoad()
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

    
    @IBAction func backToMap(_ sender: UIBarButtonItem) {
        
        let mapController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "map")
        present(mapController, animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemTableViewCell
        cell.item.text = itemArray[indexPath.row]
        cell.price.text = "$" + String(priceArray[indexPath.row])
        //cell.prizeImage.image = UIImage(named: "chickenatteck")
        
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
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func loadDataFromRealM(){
        let realM = try! Realm()
        loadItems = realM.objects(placeItemBO.self).filter("placeID = '\(placeID)'")
        if let loadData = loadItems{
            print(loadData.count)
             print("fileURL: \(realM.configuration.fileURL!)")
            totalCount = loadData.count
            
            itemArray.removeAll()
            priceArray.removeAll()
            prizeArray.removeAll()
            serialArray.removeAll()
            placekeyArray.removeAll()
            for result in loadData{
                itemArray.append(result.item)
                priceArray.append(result.price)
                prizeArray.append(result.prize)
                serialArray.append(result.serial)
                placekeyArray.append(result.placeKey)
            }
        }
    }
    
    func backToDetil(placeId: String) {
        placeID = placeId
        //重新讀取資料
         loadDataFromRealM()
        detailTableView.reloadData()
    }
}
