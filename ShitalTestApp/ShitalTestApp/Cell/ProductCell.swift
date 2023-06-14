//
//  ProductCell.swift
//  ShitalTestApp
//
//  Created by ShitalJadav on 08/06/23.
//

import UIKit

class ProductCell: UICollectionViewCell {

    // MARK: Outlets
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var btnFav: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnAdd.layer.cornerRadius = 10
        btnAdd.layer.borderColor = UIColor.systemGreen.cgColor
        btnAdd.layer.borderWidth = 1
    }

}
