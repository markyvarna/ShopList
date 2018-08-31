//
//  ItemTableViewCell.swift
//  ShopList
//
//  Created by Markus Varner on 8/31/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

//MARK: - Protocol
protocol ItemTableViewCellDelegate: class{
    
    func didBuyToggled(cell: ItemTableViewCell)
    
}

class ItemTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    weak var delegate: ItemTableViewCellDelegate?
    
    var item: Item? {
        didSet{
            updateView()
        }
    }

    //MARK: - Outlets
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var didBuyButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK: - Update Cell View
    func updateView() {
        
        guard let item = item else {return}
        nameLabel.text = item.name
        
        if item.didBuy == true {
            didBuyButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            didBuyButton.setImage(UIImage(named: "unChecked"), for: .normal)
        }
        
    }

    //MARK: - Actions
    @IBAction func didBuyButtonTapped(_ sender: UIButton) {
        
        //cell delegate method
        self.delegate?.didBuyToggled(cell: self)
        
    }
    
    

}
/*
 
 
 */
