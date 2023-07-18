//
//  DecimalUtil.swift
//  Bankey
//
//  Created by Kieran Crown on 14/07/2023.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
