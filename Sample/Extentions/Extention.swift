//
//  Extention.swift
//  Sample
//
//  Created by Vipin Saini on 07/05/22.
//

import Foundation
import UIKit

//MARK:- Custom Color
extension UIColor {
    @nonobjc class var blueDark: UIColor {
        return UIColor(named: "blueDark")!
    }
    @nonobjc class var blueLight: UIColor {
        return UIColor(named: "blueLight")!
    }
    @nonobjc class var blueSubTitle: UIColor {
        return UIColor(named: "blueSubTitle")!
    }
    @nonobjc class var grayPlaceholder: UIColor {
        return UIColor(named: "grayPlaceholder")!
    }
    @nonobjc class var greenDark: UIColor {
        return UIColor(named: "greenDark")!
    }
    @nonobjc class var greenLight: UIColor {
        return UIColor(named: "greenLight")!
    }
    @nonobjc class var skyBlueLight: UIColor {
        return UIColor(named: "skyBlueLight")!
    }
    @nonobjc class var whiteL: UIColor {
        return UIColor(named: "whiteL")!
    }
}

    //MARK: - View
extension UIView {
    
    @IBInspectable var viewCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var viewBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var viewBorderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
        
    
    func addTapGesture(action : @escaping ()->Void ){
        let tap = MyTapGestureRecognizer(target: self , action: #selector(self.handleTap(_:)))
        tap.action = action
        tap.numberOfTapsRequired = 1
        
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
        
    }
    
    @objc func handleTap(_ sender: MyTapGestureRecognizer) {
        UIView.transition(with: self, duration: 0.35, options: .showHideTransitionViews, animations: {
            sender.action!()
        })
    }
     
    func addBorderAndColor(color: UIColor, width: CGFloat, corner_radius: CGFloat = 0, clipsToBounds: Bool = false) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = corner_radius
        self.clipsToBounds = clipsToBounds
    }
 
    func applyGradient(isVertical: Bool, colorArray: [UIColor], viewBound: CGRect?) {
        layer.sublayers?.filter({ $0 is CAGradientLayer }).forEach({ $0.removeFromSuperlayer() })
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colorArray.map({ $0.cgColor })
        if isVertical {
                //top to bottom
            gradientLayer.locations = [0.0, 1.0]
        } else {
                //left to right
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        }
        
        backgroundColor = .clear
        gradientLayer.frame = viewBound ?? bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
 
    
    func addRoundShadow(cornerRadius: CGFloat, size: CGRect) {
        var shadowLayer: CAShapeLayer!
        clipsToBounds = false
        shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: size, cornerRadius: cornerRadius).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        
        shadowLayer.shadowColor = UIColor.darkGray.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        shadowLayer.shadowOpacity = 0.5
        shadowLayer.shadowRadius = 2
        layer.insertSublayer(shadowLayer, at: 0)
    }
}


    //MARK: - Tap Gesture Action
class MyTapGestureRecognizer: UITapGestureRecognizer {
    var action : (()->Void)? = nil
    
    var highlightOnTouch = true
    var bgColorView:UIColor = .clear
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        let bgcolor = self.view?.backgroundColor
        if let colorSet = bgcolor {
            bgColorView = colorSet
        }
        
        if highlightOnTouch {
            self.highlightOnTouch = false
            UIView.animate(withDuration: 0.2, delay: 0, options: [.allowUserInteraction, .curveLinear], animations: {
                self.view?.alpha = 0.7
            }) { (_) in
                UIView.animate(withDuration: 0.2, delay: 0, options: [.allowUserInteraction, .curveLinear], animations: {
                    self.highlightOnTouch = true
                    self.view?.alpha = 1
                })
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        
        if highlightOnTouch {
            UIView.animate(withDuration: 0.2, delay: 0, options: [.allowUserInteraction, .curveLinear], animations: {
                self.highlightOnTouch = true
                self.view?.alpha = 1
            })
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        
        if highlightOnTouch {
            UIView.animate(withDuration: 0.2, delay: 0, options: [.allowUserInteraction, .curveLinear], animations: {
                self.highlightOnTouch = true
                self.view?.alpha = 1
            })
        }
    }
}
 
