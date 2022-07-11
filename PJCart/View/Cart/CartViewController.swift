//
//  CartViewController.swift
//  PJCart
//
//  Created by PujieLee on 2022/7/2.
//

import UIKit

class CartViewController : BaseViewController{
    
    @IBOutlet weak var Tb_GoodList: UITableView!
    @IBOutlet weak var Btn_Checkout: UIButton!
    @IBOutlet weak var Lbl_Total: UILabel!
    
    lazy var model: CartViewModel = { //view model
        return CartViewModel()
    }()
    
    var viewData: CartViewData { //view data
        return model.viewData
    }
    
    lazy var btnReturn: UIButton = {
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 34))
        btn.setTitleColor(UIColor.init(rgb: 0x007AFF), for: .normal)
        btn.setTitle("返回", for: .normal)
        btn.addTarget(self, action: #selector(returnPrevious), for: .touchUpInside)
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewInit()
        dataBinding()
        model.start(self)
    }
    
    func viewInit() {
        
        //設定navigation bar
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btnReturn)
        
        //設定列表
        Tb_GoodList.delegate = self
        Tb_GoodList.dataSource = self
        Tb_GoodList.register(UINib(nibName: "CartViewCell", bundle: nil), forCellReuseIdentifier: "CartViewCell")
        
//        Tb_GoodList.estimatedRowHeight = 136.0
        Tb_GoodList.rowHeight = 136.0
    }
    
    func dataBinding() {
        viewData.cartListData.addObserver {[weak self] dicOrder in
            self?.Tb_GoodList.reloadData()
            self?.Lbl_Total.text = self?.model.getTotalCostString()
            
            //set "Checkout" enabled
            self?.Btn_Checkout.isEnabled = dicOrder.count > 0
        }
        
        viewData.isLoading.addObserver {[weak self] isLoading in
            if isLoading {
                self?.NVStartLoading(message: "讀取中...")
            }else{
                self?.RemoveNV()
            }
        }
    }
    
    @objc func returnPrevious(){
        self.dismiss(animated: false)
    }
    
    //MARK: UI event
    @IBAction func BtnCheckoutClicked(_ sender: Any) {
        model.runCheckout()
    }
    
}

//MARK: table relate
extension CartViewController : UITableViewDataSource , UITableViewDelegate, CartViewCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.viewData.cartListData.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CartViewCell", for: indexPath) as! CartViewCell
        cell.selectionStyle = .none
        
        cell.setCellData(model.viewData.cartListData.value[indexPath.row])
        cell.cellIdx = indexPath
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func updateBuyCount(_ count: Int, cellIdx: IndexPath){
        Lbl_Total.text = model.getTotalCostString()
    }
    
    func removeGoodsFromCart(cellIdx: IndexPath){
        model.removeGoodsFromCart(at: cellIdx.row)
    }
}
