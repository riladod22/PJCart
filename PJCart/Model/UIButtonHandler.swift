//
//  UIButtonHandler.swift
//  PJCart
//
//  Created by PujieLee on 2022/7/2.
//

import UIKit
import SnapKit

/*
 Cart button on top of 'GoodsViewController'
 */
class ButtonCart :UIButton {
 
    var Lbl_Count: UILabel =  UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupAppearance()
        self.initLblCount()
    }
    
    override func didMoveToSuperview() {
        
    }
    
    private func setupAppearance(){
        
        self.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self.frame.size.width)
            make.height.equalTo(self.frame.size.width)
        }
        
        self.setBackgroundImage(UIImage.init(named: "cart"), for: .normal)
        
    }
    
    private func initLblCount(){
        
        let btnWidth: CGFloat = self.frame.size.width
        
        //setup tip count
        Lbl_Count.frame = CGRect.init(x: btnWidth-10.0, y: -10, width: 20.0, height: 20.0)
        Lbl_Count.backgroundColor = UIColor.red
        Lbl_Count.layer.cornerRadius = 10.0
        Lbl_Count.textColor = UIColor.white
        Lbl_Count.text = "0"
        Lbl_Count.textAlignment = .center
        Lbl_Count.layer.masksToBounds = true
        Lbl_Count.adjustsFontSizeToFitWidth = true
        
        Lbl_Count.isHidden = true
        
        self.addSubview(Lbl_Count)
    }
    
    func setCount(_ count:Int){
        Lbl_Count.isHidden = (count<=0)
        Lbl_Count.text = (count>99 ? "99" : String(count))
    }
}
