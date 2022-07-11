//
//  UIViewControllerHandler.swift
//  PJCart
//
//  Created by PujieLee on 2022/7/2.
//

import UIKit
import NVActivityIndicatorView

class BaseViewController :UIViewController {
    
    //Loading progress animation
    lazy var nvIndicator: NVActivityIndicatorView = {
        var indicator = NVActivityIndicatorView(frame: .zero, type: .lineSpinFadeLoader, color: .white, padding: 0)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    //Gray mask
    lazy var viLoadingMask: UIView = {
        var mask = UIView(frame: .zero)
        mask.translatesAutoresizingMaskIntoConstraints = false
        mask.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        return mask
    }()

    func NVStartLoading(message: String?) -> Void{
        //Start loading progress animation

        if(viLoadingMask.superview == nil){
            view.addSubview(viLoadingMask)
            setViewMatchParent(vi:viLoadingMask)
        }

        if(nvIndicator.superview == nil){
            view.addSubview(nvIndicator)

            let horizontalConstraint = NSLayoutConstraint(item: nvIndicator, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nvIndicator.superview, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
            let verticalConstraint = NSLayoutConstraint(item: nvIndicator, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nvIndicator.superview, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
            let widthConstraint = NSLayoutConstraint(item: nvIndicator, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40)
            let heightConstraint = NSLayoutConstraint(item: nvIndicator, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40)
            NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])

            nvIndicator.startAnimating()
        }
    }

    func RemoveNV() -> Void{
        //Remove loading progress animation
        viLoadingMask.removeFromSuperview()
    
        nvIndicator.stopAnimating()
        nvIndicator.removeFromSuperview()
    }
    
    func showAlertMessage(title:String, message:String, target:UIViewController, okEvent: (()->Void)? ) {
        //Message label
        
        let action = UIAlertController(title: title, message: message,  preferredStyle: .alert)
        action.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            if let event = okEvent {
                event()
            }
        }))
        
        target.present(action, animated: true, completion: nil)
    }
}
