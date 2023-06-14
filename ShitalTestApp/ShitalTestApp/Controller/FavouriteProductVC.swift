//
//  FavouriteProductVC.swift
//  ShitalTestApp
//
//  Created by ShitalJadav on 08/06/23.
//

import UIKit

class FavouriteProductVC: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblNotFound: UILabel!
    
    var productData:[ProductModel] = [ProductModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ProductCell", bundle: nil)
        productCollectionView?.register(nib, forCellWithReuseIdentifier: "ProductCell")
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if selectedData.count > 0 {
            self.lblNotFound.isHidden = true
            self.productCollectionView.reloadData()
        } else {
            self.lblNotFound.isHidden = false
        }
    }
    
    // MARK: Functions
    @objc func onTapUnFavProduct(sender : UIButton) {
        selectedData.remove(at: sender.tag)
        if selectedData.count > 0 {
            self.lblNotFound.isHidden = true
            self.productCollectionView.reloadData()
        } else {
            self.lblNotFound.isHidden = false
        }
    }
}

// MARK: Collectopnview Methods
extension FavouriteProductVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath as IndexPath) as! ProductCell
        let data = selectedData[indexPath.row]
        cell.lblProductName.text = data.title
        cell.lblProductPrice.text = "\(data.price[0].value ?? 0)"
        let url = URL(string: data.imageURL)
        if let data = try? Data(contentsOf: url!) {
            cell.imgProduct.image = UIImage(data: data)
        }
        cell.btnFav.tag = indexPath.row
        cell.btnFav.setImage(UIImage(named: "fav-on"), for: .normal)
        cell.btnFav.addTarget(self,action: #selector(onTapUnFavProduct(sender:)),for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width) / 2)
        print("cell width : \(width)")
        return CGSize(width: width, height: 213)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC
        vc.modalPresentationStyle = .overFullScreen
        vc.strTitle = selectedData[indexPath.row].title
        vc.strPrice = "\(selectedData[indexPath.row].price[0].value ?? 0)"
        vc.strDetails = selectedData[indexPath.row].brand
        vc.strImgurl = selectedData[indexPath.row].imageURL
        self.present(vc, animated: true, completion: nil)
    }
}
