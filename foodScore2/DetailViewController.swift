//
//  DetailViewController.swift
//  foodScore2
//
//  Created by Tsai Meng Han on 2020/2/18.
//  Copyright © 2020 Tsai Meng Han. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var placeID:String = ""
    var name:String = ""
    @IBOutlet var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(placeID)
        print(name)
        
        //給商家名稱
        nameLabel.text = name
        // Do any additional setup after loading the view.
    }
    

    @IBAction func itemPriceInsert(_ sender: UIButton) {
        
        let itemPriceController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "item")
        
        present(itemPriceController, animated: true, completion: nil)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
