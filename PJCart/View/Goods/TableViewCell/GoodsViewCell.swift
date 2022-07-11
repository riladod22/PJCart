//
//  GoodsViewCell.swift
//  PJCart
//
//  Created by PujieLee on 2022/7/2.
//

import UIKit
import SDWebImage

protocol GoodsViewCellDelegate {
    func addToCart(withIndex cellIdx: IndexPath)
}

class GoodsViewCell: UICollectionViewCell {
    
    @IBOutlet weak var Iv_GoodsImage: UIImageView!
    @IBOutlet weak var Lbl_GoodsName: UILabel!
    @IBOutlet weak var Lbl_PriceOriginal: UILabel!
    @IBOutlet weak var Lbl_Price: UILabel!
    @IBOutlet weak var Vi_Background: UIView!
    
    var delegate : GoodsViewCellDelegate?
    var cellIdx: IndexPath?
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        Vi_Background.useBlackBorder()
    }
    
    func setCellData(_ data: GoodsRepo.Goods) {

        Iv_GoodsImage.sd_setImage(with: URL(string: data.img ?? ""))
        Lbl_GoodsName.text = data.name
        Lbl_PriceOriginal.setPriceWithCheckValue(data.price_original)
        Lbl_Price.setPriceWithCheckValue(data.price)
    }
    
    //MARK: ui event
    @IBAction func Btn_CartAdd(_ sender: Any) {
        
        if let cellIdx = cellIdx {
            self.delegate?.addToCart(withIndex: cellIdx)
        }
    }
    
}

private extension UILabel {
    func setPriceWithCheckValue(_ price:Int?){
        var showText = ""
        if let p = price {
            if p > 0 {
                showText = "NT$\(p)"
            }
        }
        
        let strokeEffect: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.strikethroughColor: UIColor.init(rgb: 0xAEAEB2),
        ]
        
        self.attributedText = NSAttributedString(string: showText, attributes: strokeEffect)
    }
}

private extension UIView {
    func useBlackBorder(){
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
    }
}
