//
//  Numeric+Extensions.swift
//  Cproject
//
//  Created by jercy on 12/2/23.
//

import Foundation

extension Numeric {
    var moneyString: String {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return (formatter.string(for: self) ?? "") + "원"
    }
}
