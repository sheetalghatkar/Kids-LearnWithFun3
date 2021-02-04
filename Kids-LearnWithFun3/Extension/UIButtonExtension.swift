//
//  UIButtonExtension.swift
//  Kids-LearnWithFun
//
//  Created by sheetal shinde on 15/06/20.
//  Copyright © 2020 sheetal shinde. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class RoundButton : UIButton{
    private var _round = false
    private var _borderColor = UIColor.clear
    private var _borderWidth: CGFloat = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }

    override func prepareForInterfaceBuilder() {
        sharedInit()
    }

    func sharedInit() {
        refreshCorners(value: cornerRadius)
    }

    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    @IBInspectable var round: Bool {
        set {
            _round = newValue
            makeRound()
        }
        get {
            return self._round
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        set {
            _borderColor = newValue
            setBorderColor()
        }
        get {
            return self._borderColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 5 {
        didSet {
            setBorderWidth(value: borderWidth)
        }
//        set {
//            _borderWidth = newValue
//            setBorderWidth()
////        }
//        get {
//            return self._borderWidth
//        }
    }

    override internal var frame: CGRect {
        set {
            super.frame = newValue
            makeRound()
        }
        get {
            return super.frame
        }
    }

    private func makeRound() {
        if self.round {
            self.clipsToBounds = true
          //  self.layer.cornerRadius = (self.frame.width + self.frame.height) / 4
            self.layer.masksToBounds = true
            print("Inside Learn wth fun:",self.frame.width, self.frame.height )
            self.layer.cornerRadius = self.frame.width  / 2
        } else {
            self.layer.cornerRadius = 0
        }
    }
    
    private func setBorderColor() {
        self.layer.borderColor = self._borderColor.cgColor
    }

    private func setBorderWidth(value: CGFloat) {
        self.layer.borderWidth = value
    }
    @IBInspectable var shadowColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25) {
        didSet {
            layer.borderColor = borderColor.cgColor
            setNeedsLayout()
        }
    }

    @IBInspectable var shadowOpacity: Float = 0.2 {
        didSet {
            layer.shadowOpacity = shadowOpacity
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            layer.shadowRadius = shadowRadius
            setNeedsLayout()
        }
    }

    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0.0, height: 2.0) {
        didSet {
            layer.shadowOffset = shadowOffset
            setNeedsLayout()
        }
    }


    
}

