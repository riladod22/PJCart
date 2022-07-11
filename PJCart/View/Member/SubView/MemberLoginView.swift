//
//  MemberLoginView.swift
//  PJCart
//
//  Created by PujieLee on 2022/7/2.
//

import UIKit
 
class MemberLoginView: UIView, UITextFieldDelegate {

    @IBOutlet weak var Tv_Account: UITextField!
    @IBOutlet weak var Tv_Password: UITextField!
    @IBOutlet weak var Btn_Login: UIButton!
    
    var model: MemberViewModel? //check一下？？  循環飲用？
    var viewData: MemberViewData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func startView(withModel model: MemberViewModel){
        self.model = model
        self.viewData = model.viewData
        
        setupView()
        setupGesture()
    }
    
    func setupView(){
        Tv_Account.delegate = self
        Tv_Password.delegate = self
    }
    
    func setupGesture(){
        //add gesture to close keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
        self.addGestureRecognizer(tap)
    }
    
    //MARK: UI event
    @IBAction func BtnLoginClikced(_ sender: Any) {
        self.endEditing(true)
        model?.runLogin()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == Tv_Account {
            viewData?.inputedLoginAccount = textField.text ?? ""
        }else if textField == Tv_Password{
            viewData?.inputedLoginPassword = textField.text ?? ""
        }
    }
    
    //
    deinit {
        viewData?.inputedLoginAccount = ""
        viewData?.inputedLoginPassword = ""
    }
}


