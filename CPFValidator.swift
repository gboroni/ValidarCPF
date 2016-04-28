//
//  CPFValidator.swift
//  DireitoMais
//
//  Created by Guilherme Boroni on 28/04/16.
//  Copyright © 2016 Fanese. All rights reserved.
//



import Foundation

class CPFValidator {
    
   static func validateCPF(cpf: NSString) -> Bool {
        
        var valid = true
        
        // ignore punctuation
        let cleanCPF: NSString = cpf.stringByTrimmingCharactersInSet(NSCharacterSet.punctuationCharacterSet())
        
        // ignore CPFs with wrong length
        if cpf.length != 11 {
            valid = false
            print("wrong length cpf: \(cpf)")
            return valid
        }
        
        // invalidate other characters
        let range = cleanCPF.rangeOfCharacterFromSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
        if range.location != NSNotFound {
            valid = false
            print("clean cpf: \(cleanCPF)")
            return valid
        }
        
        let baseCPF: NSString = cleanCPF.substringToIndex(9)
        print("cpf base: \(baseCPF)")
        
        func digitMultiplier(digitString: NSString, range: Range<Int>) -> Int {
            var sum: Int = 0
            var index: Int = 0
            for multiplier in range {
                let aChar: String = digitString.substringWithRange(NSMakeRange(index, 1))
                if let digit: Int? = Int(aChar) {
                    sum += digit! * multiplier
                }
                index += 1
            }
            return sum
        }
        
        // array to store the digits
        var dv = [Int](count: 2, repeatedValue:0)
        
        let sum0 = digitMultiplier(baseCPF, range: 1...9)
        dv[0] = sum0 % 11
        
        // append the first digit
        let aChar: NSString = NSString.localizedStringWithFormat("%d", dv[0])
        var cpf2: NSString = baseCPF.stringByAppendingString(aChar as String)
        
        let sum1 = digitMultiplier(cpf2, range: 0...9)
        dv[1] = sum1 % 11
        
        // digit check
        let digits: NSString = cpf.substringFromIndex(9)
        for i in 0...1 {
            let digitStr: String = digits.substringWithRange(NSMakeRange(i, 1))
            let digit: Int = Int(digitStr)!
            if dv[i] != digit {
                valid = false
            }
        }
        
        return valid
    }
}
