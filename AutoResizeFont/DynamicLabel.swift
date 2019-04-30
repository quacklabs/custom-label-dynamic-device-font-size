//
//  DynamicLabel.swift
//  AutoResizeFont
//
//  Created by Wisdom Arerosuoghene on 27/04/2019.
//  Copyright © 2019 Wisdom Arerosuoghene. All rights reserved.
//

import UIKit

@IBDesignable
final class DynamicLabel: UILabel {
    
    
    
    @IBInspectable
    var fontSize: CGFloat {
        get{
            return self.font!.pointSize
        }
        set{
            self.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: newValue)
            calculateFontSize()
        }
    }
    
    
    // Override font for view.
    override var font : UIFont?{
        
        didSet{
            setNeedsLayout()
            setNeedsDisplay()
            self.sizeToFit()
        }
    }
    
    // Deduced by multiplying the height of the Label by a constant.
    var relativeHeight : CGFloat!
    
    // Relative constant to multiply our initial element height.
    // This lets us double the size on bigger devices
    let relativeFontConstant:CGFloat = 0.1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        relativeHeight = CGFloat(frame.height * relativeFontConstant)
        calculateFontSize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        relativeHeight = CGFloat(frame.height * relativeFontConstant)
        calculateFontSize()
    }
    
    // Calculate fonts for iPad, iPhone and iPod.
    func calculateFontSize() {
        
        switch UIDevice().type {
        case .iPhoneSE, .iPhone5, .iPhone5S, .iPhone5C:
            self.font = self.font!.withSize(self.font!.pointSize) //leave font size the same as from Interface builder
        case .iPhone6, .iPhone6S, .iPhone7, .iPhone8:
            self.font = self.font!.withSize(self.font!.pointSize * (relativeHeight / 2))
        case .iPhone6plus, .iPhone6Splus, .iPhone7plus, .iPhone8plus:
            self.font = self.font!.withSize(self.font!.pointSize * (relativeHeight / 2) )
        case .iPhoneX, .iPhoneXR, .iPhoneXS, .iPhoneXSMax:
            self.font = self.font!.withSize(self.font!.pointSize * (relativeHeight / 3) )
        case .iPad2, .iPad3, .iPad4, .iPad5, .iPad6, .iPadAir, .iPadMini, .iPadPro2_12_9:
            self.font = self.font!.withSize(self.font!.pointSize * relativeHeight)
        case .iPod1, .iPod2, .iPod3, .iPod4, .iPod5:
            self.font = self.font!.withSize(self.font!.pointSize * (relativeHeight / 4 ) )
        default:
            self.font = self.font!.withSize(self.font!.pointSize * relativeHeight)
        }
    }
}
