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
    var fontSizePts: CGFloat {
        didSet {
            calculateFontSize()
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        fontSizePts = 14
        super.init(frame: frame);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fontSizePts = 14
        super.init(coder: aDecoder);
    }
    
    // todo calculate fonts for iPad and iPod
    func calculateFontSize() {
        switch UIDevice().type {
        case .iPhoneSE, .iPhone5, .iPhone5S, .iPhone5C:
            self.font = self.font.withSize(self.fontSizePts)
        case .iPhone6, .iPhone6S, .iPhone7, .iPhone8:
            self.font = self.font.withSize(self.fontSizePts * 2)
        case .iPhone6plus, .iPhone6Splus, .iPhone7plus, .iPhone8plus:
            self.font = self.font.withSize(self.fontSizePts * 2)
        case .iPhoneX, .iPhoneXR, .iPhoneXS, .iPhoneXSMax:
            self.font = self.font.withSize(self.fontSizePts * 3)
        default:
            self.font = self.font.withSize(self.fontSizePts * 4)
        }
        print(self.font.pointSize)
    }
}
