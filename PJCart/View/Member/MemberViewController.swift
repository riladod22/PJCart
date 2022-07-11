//
//  MemberViewController.swift
//  PJCart
//
//  Created by PujieLee on 2022/7/2.
//

import UIKit
import Alamofire
import ObjectMapper

class MemberViewController: BaseViewController {
    
    @IBOutlet weak var St_MainView: UIStackView!
    
    var insertedView: UIView?
    
    lazy var model: MemberViewModel = { //view model
        return MemberViewModel()
    }()
    
    var viewData: MemberViewData { //view data
        return model.viewData
    }
    
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
        model.start(self)
    }
    
    func viewInit() {
        title = "會員中心"
    }
    
    func dataBinding() {
        
        viewData.isLoading.addObserver(sendNow: false) { [weak self] isLoading in
            if isLoading {
                self?.NVStartLoading(message: "讀取中...")
            }else{
                self?.RemoveNV()
            }
        }
    
        viewData.currentLoginStatus.addObserver(sendNow: false) { currentLoginStatus in
            self.reloadView()
        }
    }
}

extension MemberViewController {
    func reloadView() {
        
        //clean view
        if insertedView != nil {
            insertedView?.removeFromSuperview()
            insertedView = nil
        }
        
        //insert view
        insertedView = model.createMemberView()
        St_MainView.addArrangedSubview(insertedView!)
    }
}
