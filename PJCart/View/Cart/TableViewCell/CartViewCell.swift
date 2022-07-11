//
//  CartViewCell.swift
//  PJCart
//
//  Created by PujieLee on 2022/7/2.
//

import UIKit
import SDWebImage

struct CartViewCellData {
    let gid: String
    let img: String
    let name: String
    let price: Int
    var buy_count: Observerable<Int>
    
    init(goods: GoodsRepo.Goods) {
        self.gid = goods.gid ?? ""
        self.img = goods.img ?? ""
        self.name = goods.name ?? ""
        self.price = goods.price ?? 0
        self.buy_count = Observerable.init(value: 1) //預設1
    }
}

protocol CartViewCellDelegate {
    func updateBuyCount(_ count: Int, cellIdx: IndexPath)
    func removeGoodsFromCart(cellIdx: IndexPath)
}

class CartViewCell : UITableViewCell {

    @IBOutlet weak var Iv_GoodsImage: UIImageView!
    @IBOutlet weak var Lbl_GoodsName: UILabel!
    @IBOutlet weak var Lbl_Price: UILabel!
    @IBOutlet weak var Btn_Remove: UIButton!
    
    @IBOutlet weak var Btn_Add: UIButton!
    @IBOutlet weak var Btn_Discount: UIButton!
    @IBOutlet weak var Tf_BuyCount: UITextField!
    
    var delegate : CartViewCellDelegate?
    var cellIdx: IndexPath?
    var cellData: CartViewCellData?
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setCellData(_ data: CartViewCellData) {
        
        cellData = data
        
        Iv_GoodsImage.sd_setImage(with: URL(string: data.img))
        Lbl_GoodsName.text = data.name
        Lbl_Price.text = String(data.price)
        Tf_BuyCount.text = String(data.buy_count.value)
        
        //data binding
        data.buy_count.addObserver {[weak self] buyCount in
            self?.Tf_BuyCount.text = String(data.buy_count.value)
        }
    }
    
    func updateBuyCount(_ value: Int){
        cellData?.buy_count.value = value
        //Tf_BuyCount.text = String(value)
        
        if let cellIdx = cellIdx {
            delegate?.updateBuyCount(value, cellIdx: cellIdx)
        }
    }
    
    @IBAction func BtnRemoveClicked(_ sender: Any) {
        if let cellIdx = cellIdx {
            delegate?.removeGoodsFromCart(cellIdx: cellIdx)
        }
    }
    
    @IBAction func BtnAddClicked(_ sender: Any) {
        guard let data = cellData  else{ return }
        
        let buyCount = data.buy_count.value
        if buyCount < 99 {
            updateBuyCount(buyCount+1)
        }
    }
    
    @IBAction func BtnDicountClicked(_ sender: Any) {
        guard let data = cellData else{ return }
        
        let buyCount = data.buy_count.value
        if buyCount > 1 {
            updateBuyCount(buyCount-1)
        }
    }
    
}
