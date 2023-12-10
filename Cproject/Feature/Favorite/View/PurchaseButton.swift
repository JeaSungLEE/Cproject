//
//  PurchaseButton.swift
//  Cproject
//
//  Created by jercy on 12/3/23.
//

import UIKit

final class PurchaseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = CPColor.UIKit.keyColorBlue.cgColor
        setTitleColor(CPColor.UIKit.keyColorBlue, for: .normal)
        setTitle("구매하기", for: .normal)
    }
}
