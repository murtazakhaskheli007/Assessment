//
//  DesignableView.swift
//  NY Times
//
//  Created by Ghulam Murtaza on 12/07/2024.
//

import Foundation
import UIKit

@IBDesignable
class CGDesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        context.stroke(self.bounds.insetBy(dx: 1.0, dy: 1.0))
        super.drawText(in: rect.insetBy(dx: 5.0, dy: 3.0))
    }
}

@IBDesignable
class DesignableUITextField: UITextField {
    
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    // Provides left padding for images
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= leftPadding
        return textRect
    }
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView1()
        }
    }
    
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
    
    
    func updateView1() {
        if let image = rightImage {
            rightViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            rightView = imageView
        } else {
            rightViewMode = UITextField.ViewMode.never
            rightView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
}




extension UIView {
    
    func roundCornersView(corners: UIRectCorner, radius: CGFloat) {
        
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        layer.borderWidth = 3
    }
    
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        /* let mask = CAShapeLayer()
         
         
         let rect = self.bounds
         mask.frame = rect
         mask.path = path.cgPath
         
         mask.shadowColor = UIColor.black.cgColor
         mask.shadowRadius = 8.0
         mask.shadowOpacity = 0.9
         mask.shadowOffset = CGSize(width: 1, height: 1)
         
         
         self.layer.mask = mask*/
        
        let shadowLayer = CAShapeLayer()
        
        shadowLayer.path = path.cgPath
        
        
        
       /* shadowLayer.fillColor = UIColor.white.cgColor //fillColor.cgColor
        
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        shadowLayer.shadowOpacity = 0.2
        shadowLayer.shadowRadius = 3
        */
        self.layer.insertSublayer(shadowLayer, at: 0)
        
        
    }
    
    //private var _round = false
    
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    @IBInspectable
    var round: Bool {
        set {
            // _round = newValue
            // makeRound()=
            self.clipsToBounds = true
            self.layer.cornerRadius =  self.frame.height * 0.5
        }
        get {
            //return self._round
            self.layer.cornerRadius = 0
            return false
        }
    }
    
    func makeRound() {
        //if self.round {
            self.clipsToBounds = true
            self.layer.cornerRadius = (self.frame.width + self.frame.height) / 4
        /*} else {
            self.layer.cornerRadius = 0
        }*/
    }
}





