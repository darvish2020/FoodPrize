//
//  DetailViewController.swift
//  foodScore2
//
//  Created by Tsai Meng Han on 2020/2/18.
//  Copyright © 2020 Tsai Meng Han. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var nav: UINavigationBar!
    var placeID:String = ""
    var name:String = ""
    @IBOutlet var nameLabel: UILabel!
    override func viewDidLoad() {
        
        if #available(iOS 13.0, *) {
            nav.isHidden = true
        }else{
//                        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
//                        view.addSubview(navBar)
//
//                        let navItem = UINavigationItem(title: "SomeTitle")
            //            let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(selectorName:))
            //            navItem.rightBarButtonItem = doneItem
            //
            //            navBar.setItems([navItem], animated: false)
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
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
