//
//  MemberViewModel.swift
//  PJCart
//
//  Created by PujieLee on 2022/7/2.
//

import UIKit

//MARK: data
class MemberViewData {
    var isLoading = Observerable<Bool>(value: false)
    var currentLoginStatus = Observerable<Int>(value: -1)
    
    var inputedLoginAccount: String = ""
    var inputedLoginPassword: String = ""
    //var howMess: String = ""
}

//MARK: view model
class MemberViewModel {
    let apiService: ApiService
    var viewData: MemberViewData
    weak var viewController: MemberViewController?
    
    init(apiService: ApiService = ApiService(),
        memberViewData: MemberViewData = MemberViewData()) {
        self.apiService = apiService
        self.viewData = memberViewData
    }
    
    func start(_ viewController: MemberViewController){
        
        self.viewController = viewController
        
        viewData.currentLoginStatus.value = (UserDataStorage.sharedInstance.userData != nil) ? 1 : 0
    }
    
    func runLogin(){
        
        if checkLogin() {
            postUserLogin()
        }
    }
    
    func checkLogin() -> Bool{
        
        var result = true
        
        if viewData.inputedLoginAccount.count == 0 {
            showCheckMessage("請輸入帳號")
            result = false
        }else if viewData.inputedLoginPassword.count == 0 {
            showCheckMessage("請輸入密碼")
            result = false
        }
            
        return result
    }
    
    func showCheckMessage(_ message:String){
        if let viewController = viewController {
            viewController.showAlertMessage(title: "訊息",
                                            message:message ,
                                            target: viewController,
                                            okEvent: {
                viewController.dismiss(animated: true)
            })
        }
    }
    
    func postUserLogin(){
        //api post userlogin
        viewData.isLoading.value = true
        
        ApiService.sharedInstance.postUserLogin(username: viewData.inputedLoginAccount, password: viewData.inputedLoginPassword) {[weak self] userLoginRepo, error in
            self?.viewData.isLoading.value = false
            
            if let repo = userLoginRepo {
                self?.viewData.currentLoginStatus.value = 1
                UserDataStorage.sharedInstance.userData = repo
            }else if let errMsg = error {
                print(errMsg) //show error message
            }
        }
    }
    
    func runUserLogout(){
        //logout
        viewData.currentLoginStatus.value = 0
        UserDataStorage.sharedInstance.userData = nil
    }
    
    func createMemberView() -> UIView{
        
        if UserDataStorage.sharedInstance.userData != nil {
            //is login : show user info
           
            let view = Bundle(for: MemberInfoView.self).loadNibNamed(String(describing: MemberInfoView.self), owner: nil, options: nil)![0] as! MemberInfoView
            view.startView(withModel: self)

            return view
        }else{
            //is logout : show login UI
            
            let view = Bundle(for: MemberLoginView.self).loadNibNamed(String(describing: MemberLoginView.self), owner: nil, options: nil)![0] as! MemberLoginView
            view.startView(withModel: self)
            
            return view
        }
    }
}
