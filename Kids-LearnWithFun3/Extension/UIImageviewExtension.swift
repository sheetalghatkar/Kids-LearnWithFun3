//
//  UIImageviewExtension.swift
//  Kids-LearnWithFun
//
//  Created by sheetal shinde on 14/06/20.
//  Copyright © 2020 sheetal shinde. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class RoundImageView: UIImageView {
    private var _round = false
    private var _borderColor = UIColor.clear
    private var _borderWidth: CGFloat = 0

    @IBInspectable var round: Bool {
        set {
            _round = newValue
            makeRound()
        }
        get {
            return self._round
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

    @IBInspectable var borderWidth: CGFloat {
        set {
            _borderWidth = newValue
            setBorderWidth()
        }
        get {
            return self._borderWidth
        }
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
           // print("Inside Learn wth fun:",self.frame.width, self.frame.height )
            self.layer.cornerRadius = self.frame.width  / 2
        } else {
            self.layer.cornerRadius = 0
        }
    }

    private func setBorderColor() {
        self.layer.borderColor = self._borderColor.cgColor
    }

    private func setBorderWidth() {
        self.layer.borderWidth =  5 //self._borderWidth
    }
}
    
    extension UIImageView {

        open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.alpha = 1.0
            UIImageView.animate(withDuration: 0.2, delay: 0.0, options: .curveLinear, animations: {
                self.alpha = 0.5
            }, completion: nil)
        }
    }

        open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.alpha = 0.5
            UIImageView.animate(withDuration: 0.2, delay: 0.0, options: .curveLinear, animations: {
                self.alpha = 1.0
            }, completion: nil)
        }
    }

        open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.alpha = 0.5
            UIImageView.animate(withDuration: 0.4, delay: 0.0, options: .curveLinear, animations: {
                self.alpha = 1.0
            }, completion: nil)
        }
    }
    
}

