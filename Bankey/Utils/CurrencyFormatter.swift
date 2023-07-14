//
//  CurrencyFormatter.swift
//  Bankey
//
//  Created by Kieran Crown on 14/07/2023.
//

import UIKit

struct CurrencyFormatter {
    
    func makeAttributedCurrency(_ amount: Decimal) -> NSMutableAttributedString {
        let tuple = breakIntoPoundsAndPence(amount)
        return makeBalanceAttributed(pounds: tuple.0, pence: tuple.1)
    }
    
    // Converts 929466.23 > "929,466" "23"
    func breakIntoPoundsAndPence(_ amount: Decimal) -> (String, String) {
        let tuple = modf(amount.doubleValue)
        
        let pounds = convertPound(tuple.0)
        let pence = convertPence(tuple.1)
        
        return (pounds, pence)
    }
    
    // Converts 929466 > 929,466
    private func convertPound(_ dollarPart: Double) -> String {
        let poundsWithDecimal = poundsFormatted(dollarPart) // "$929,466.00"
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        let decimalSeparator = formatter.decimalSeparator! // "."
        let dollarComponents = poundsWithDecimal.components(separatedBy: decimalSeparator) // "$929,466" "00"
        var pounds = dollarComponents.first! // "$929,466"
        pounds.removeFirst() // "929,466"
        
        return pounds
    }
    
    // Convert 0.23 > 23
    private func convertPence(_ centPart: Double) -> String {
        let pence: String
        if centPart == 0 {
            pence = "00"
        } else {
            pence = String(format: "%.0f", centPart * 100)
        }
        return pence
    }
    
    // Converts 929466 > $929,466.00
    func poundsFormatted(_ pounds: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        
        if let result = formatter.string(from: pounds as NSNumber) {
            return result
        }
        
        return ""
    }
    
    private func makeBalanceAttributed(pounds: String, pence: String) -> NSMutableAttributedString {
        let poundSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        let poundAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let penceAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        
        let rootString = NSMutableAttributedString(string: "£", attributes: poundSignAttributes)
        let poundString = NSAttributedString(string: pounds, attributes: poundAttributes)
        let penceString = NSAttributedString(string: pence, attributes: penceAttributes)
        
        rootString.append(poundString)
        rootString.append(penceString)
        
        return rootString
    }
}
