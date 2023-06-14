//
//  ProductListVC.swift
//  ShitalTestApp
//
//  Created by ShitalJadav on 08/06/23.
//

import UIKit
var selectedData:[ProductModel] = [ProductModel]()
class ProductListVC: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var lblNotFound: UILabel!
    
    // MARK: Variables
    var objViewModel = ProductViewModel()
    var selectedItem = -1
    var isSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ProductCell", bundle: nil)
        productCollectionView?.register(nib, forCellWithReuseIdentifier: "ProductCell")
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        objViewModel.fetchProductAPICall() { isSucess in
            if isSucess == true {
                DispatchQueue.main.async {
                    self.lblNotFound.isHidden = true
                    self.productCollectionView.isHidden = false
                    self.productCollectionView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.productCollectionView.reloadData()
    }
    
    // MARK: Functions
    @objc func onTapFavProduct(sender : UIButton) {
        self.selectedItem = sender.tag
        selectedData.append(self.objViewModel.arrProductDetails[sender.tag])
        self.productCollectionView.reloadData()
    }
    
}

// MARK: Collectopnview Methods
extension ProductListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.objViewModel.arrProductDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath as IndexPath) as! ProductCell
        let data = self.objViewModel.arrProductDetails[indexPath.row]
        cell.btnFav.addTarget(self,action: #selector(onTapFavProduct(sender:)),for: .touchUpInside)
        cell.lblProductName.text = data.title
        cell.lblProductPrice.text = "$\(data.price[0].value ?? 0)"
        let url = URL(string: data.imageURL)
        if let data = try? Data(contentsOf: url!) {
            cell.imgProduct.image = UIImage(data: data)
        }
        cell.btnFav.tag = indexPath.row
        cell.btnFav.isHidden = false
        if selectedData.count > 0 {
            for item in selectedData {
                if item.title == data.title {
                    cell.btnFav.isHidden = true
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width) / 2)
        return CGSize(width: width, height: 213)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC
        vc.modalPresentationStyle = .overFullScreen
        vc.strTitle = self.objViewModel.arrProductDetails[indexPath.row].title
        vc.strPrice = "$\(self.objViewModel.arrProductDetails[indexPath.row].price[0].value ?? 0)"
        vc.strDetails = self.objViewModel.arrProductDetails[indexPath.row].brand
        vc.strImgurl = self.objViewModel.arrProductDetails[indexPath.row].imageURL
        vc.strBrand = self.objViewModel.arrProductDetails[indexPath.row].brand
        vc.strRatingCount = self.objViewModel.arrProductDetails[indexPath.row].ratingCount
        self.present(vc, animated: true, completion: nil)
    }
}
