//
//  DetailViewController.swift
//  foodScore2
//
//  Created by Tsai Meng Han on 2020/2/18.
//  Copyright © 2020 Tsai Meng Han. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var loadItems:Results<placeItemBO>?
    var totalCount = 0
    @IBOutlet var nav: UINavigationBar!
    var placeID:String = ""
    var name:String = ""
    var itemArray = [String]()
    var priceArray = [Int]()
    var prizeArray = [Int]()
    var createDate = [Date]()
    @IBOutlet var nameLabel: UILabel!
    override func viewDidLoad() {
        
        if #available(iOS 13.0, *) {
            nav.isHidden = true
        }
        super.viewDidLoad()
        print(placeID)
        print(name)
        
        //給商家名稱
        nameLabel.text = name
        
        
        //save data once
//        let realMsave = try! Realm()
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
       
        
        
        //loadData
        let realM = try! Realm()
        loadItems = realM.objects(placeItemBO.self).filter("placeID = '\(placeID)'")
        if let loadData = loadItems{
            print(loadData.count)
             print("fileURL: \(realM.configuration.fileURL!)")
            totalCount = loadData.count
            
            for result in loadData{
                itemArray.append(result.item)
                priceArray.append(result.price)
                // MARK: TODO 日期轉換
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
//                var testdate = dateFormatter.string(from: result.createDate)
//                print(testdate)
            }
        }
    }
    
    
    @IBAction func itemPriceInsert(_ sender: UIButton) {
        
        
        let itemPriceController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "item")
        
        
        present(itemPriceController, animated: true, completion: nil)
        
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
       // cell.textLabel?.text = itemArray[indexPath.row]
        cell.item.text = itemArray[indexPath.row]
        cell.price.text = "$" + String(priceArray[indexPath.row])
        //cell.prizeImage.image = UIImage(named: "chickenatteck")
        
        return cell
    }
}
