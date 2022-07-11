//
//  MemberInfoView.swift
//  PJCart
//
//  Created by PujieLee on 2022/7/2.
//

import UIKit

class MemberInfoView: UIView {

    @IBOutlet weak var Iv_Card: UIImageView!
    @IBOutlet weak var Lbl_Name: UILabel!
    @IBOutlet weak var Btn_Logout: UIButton!
    
    var model: MemberViewModel?
    var viewData: MemberViewData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func startView(withModel model: MemberViewModel){
        self.model = model
        self.viewData = model.viewData
        
        setupView()
    }
    
    func setupView() {
        let userData = UserDataStorage.sharedInstance.userData
        Iv_Card.image = UIImage.init(named:"card_\(userData?.level ?? 1)")
        Lbl_Name.text = userData?.name ?? ""
    }
    
    //MARK: UI evemnt
    @IBAction func BtnLogoutClicked(_ sender: Any) {
        model?.runUserLogout()
    }
}
