//
//  DetailViewController.swift
//  ShopList
//
//  Created by Markus Varner on 8/31/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var summary = Summary()
    
    //MARK: - Outlets
    @IBOutlet var backGroundImageView: UIImageView!
    @IBOutlet var textView: UITextView!
    
    //MARK: - Landing Pad
    var itemName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       updateView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    func updateView() {
        
        guard let itemName = itemName else {return}
        
        if itemName == summary.captainID {
            backGroundImageView.image = UIImage(named: "captainamerica")
            textView.text = "\(itemName)  \n\(summary.captainAmerica)"
        } else if itemName == summary.ironID{
            backGroundImageView.image = UIImage(named: "ironman")
            textView.text = "\(itemName)  \n\(summary.ironMan)"
        }else if itemName == summary.thorID{
            backGroundImageView.image = UIImage(named: "thor")
            textView.text = "\(itemName)  \n\(summary.thor)"
        }else if itemName == summary.spiderID{
            backGroundImageView.image = UIImage(named: "spiderman")
            textView.text = "\(itemName)  \n\(summary.spiderMan)"
        } else {
            backGroundImageView.image = UIImage(named: "defaultbackground")
            textView.text = "\(itemName)"
        }
        
    }

 

}
