//
//  ProductDetailsVC.swift
//  ShitalTestApp
//
//  Created by ShitalJadav on 08/06/23.
//

import UIKit

class ProductDetailsVC: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var txtViewProductInfo: UITextView!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductTitle: UILabel!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewsecond: UIView!
    @IBOutlet weak var viewFirst: UIView!
    
    // MARK: Variables
    var strTitle:String?
    var strPrice:String?
    var strDetails:String?
    var strImgurl:String?
    var strBrand:String?
    var strRatingCount:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnAdd.layer.cornerRadius = 10
        btnAdd.layer.borderColor = UIColor.systemGreen.cgColor
        btnAdd.layer.borderWidth = 1
        viewFirst.layer.cornerRadius = 15
        viewsecond.layer.cornerRadius = 15
        self.lblProductTitle.text = self.strTitle
        self.lblProductPrice.text = self.strPrice
        self.lblProductName.text = self.strTitle
        let url = URL(string: strImgurl ?? "")
        if let data = try? Data(contentsOf: url!) {
            self.imgProduct.image = UIImage(data: data)
        }
        self.txtViewProductInfo.text = "Brand: \(self.strBrand ?? "") \n Rating: \(self.strRatingCount)"
    }
    
    // MARK: Actions
    @IBAction func OnTapBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

}
