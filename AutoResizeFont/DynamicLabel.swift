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
    
    //allow font to accept size from interface builder and scale up from there.
    //this is to let us use values from the design specs
    @IBInspectable
    var pointSize = UIFont() {
        didSet{
            self.font = pointSize
        }
    }
    
    //override font for view
    override var font : UIFont?{
        didSet{
            setNeedsLayout()
            setNeedsDisplay()
        }
    }
    
    //deduced by multiplying the height of the Label by a constant
    var relativeHeight : CGFloat!
    
    //relative constant to multiply our initial element height.
    //this lets us double the size on bigger devices
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
    
    // todo calculate fonts for iPad, iPhone and iPod
    func calculateFontSize() {
        switch UIDevice().type {
        case .iPhoneSE, .iPhone5, .iPhone5S, .iPhone5C:
            pointSize = self.font!.withSize(self.font!.pointSize)
        case .iPhone6, .iPhone6S, .iPhone7, .iPhone8:
            self.font = self.font!.withSize(self.font!.pointSize * (relativeHeight / 3))
        case .iPhone6plus, .iPhone6Splus, .iPhone7plus, .iPhone8plus:
            pointSize = self.font!.withSize(self.font!.pointSize * (relativeHeight / 3) )
        case .iPhoneX, .iPhoneXR, .iPhoneXS, .iPhoneXSMax:
            pointSize = self.font!.withSize(self.font!.pointSize * (relativeHeight / 2) )
        case .iPad2, .iPad3, .iPad4, .iPad5, .iPad6, .iPadAir, .iPadMini, .iPadPro2_12_9:
            pointSize = self.font!.withSize(self.font!.pointSize * relativeHeight)
        case .iPod1, .iPod2, .iPod3, .iPod4, .iPod5:
            pointSize = self.font!.withSize(self.font!.pointSize * (relativeHeight / 4 ) )
        default:
            pointSize = self.font!.withSize(self.font!.pointSize * relativeHeight)
        }
    }
}
