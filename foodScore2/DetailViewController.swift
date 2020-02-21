//
//  DetailViewController.swift
//  foodScore2
//
//  Created by Tsai Meng Han on 2020/2/18.
//  Copyright © 2020 Tsai Meng Han. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    @IBOutlet var nav: UINavigationBar!
    var placeID:String = ""
    var name:String = ""
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
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func itemPriceInsert(_ sender: UIButton) {
        
        
        let itemPriceController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "item")
        
        
        present(itemPriceController, animated: true, completion: nil)
        
    }

    
    @IBAction func backToMap(_ sender: UIBarButtonItem) {
        
        let mapController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "map")
        present(mapController, animated: false, completion: nil)
    }
}
