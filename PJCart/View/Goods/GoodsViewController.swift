//
//  GoodsViewController.swift
//  PJCart
//
//  Created by PujieLee on 2022/7/2.
//


/*
 待調整：
 1.初始化collectionview 高度 間距那些
 2.cell物件點擊事件（變成cell和viewcontroller共用一個 model??  等購物車做完再調整）
 */


import UIKit
import Alamofire
import ObjectMapper

class GoodsViewController: BaseViewController {
    
    @IBOutlet weak var Cv_GoodsList: UICollectionView!
    
    lazy var model: GoodsViewModel = {
        return GoodsViewModel()
    }()
    
    var viewData: GoodsViewData {
        return model.viewData
    }
    
    lazy var btnCart: ButtonCart = {
        let btn = ButtonCart.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 34))
        btn.addTarget(self, action: #selector(pushToCartView), for: .touchUpInside)
        
        CartDataStorage.sharedInstance.buttonCart = btn
        
        return btn
    }()

    required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewInit()
        dataBinding()
        model.start()
    }
    
    func viewInit() {
        setupNavigationBar()
        setupGoodList()
    }
    
    func dataBinding(){
        
        viewData.isLoading.addObserver (sendNow: false){[weak self] isLoading in
            if isLoading {
                self?.NVStartLoading(message: "讀取中...")
            }else{
                self?.RemoveNV()
            }
        }
        
        viewData.goodListData.addObserver (sendNow: false){[weak self] goods in
            self?.Cv_GoodsList.reloadData()
        }
    }
    
    @objc func pushToCartView(){
        model.pushToCartView(self)
    }
}

extension GoodsViewController {
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btnCart)
        navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    func setupGoodList(){
        Cv_GoodsList.delegate = self
        Cv_GoodsList.dataSource = self
        Cv_GoodsList?.register(UINib(nibName: "GoodsViewCell", bundle: nil), forCellWithReuseIdentifier: "GoodsViewCell")
    }
}

extension GoodsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{

    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewData.goodListData.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoodsViewCell.cellIdentifier(), for: indexPath) as! GoodsViewCell
        cell.setCellData(viewData.goodListData.value[indexPath.row])
        cell.cellIdx = indexPath
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let itemWidth:CGFloat = collectionView.frame.size.width * 0.5 - 2.0
        let itemHeight:CGFloat = itemWidth * 1.5
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4.0
    }
}

//MARK: good view cell delegate
extension GoodsViewController: GoodsViewCellDelegate{
    
    func addToCart(withIndex cellIdx: IndexPath){
        model.addToCart(withIndex: cellIdx)
    }
}
