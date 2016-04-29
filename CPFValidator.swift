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
        
        if cpf.length == 11 {
            
            let d1 = cpf.substringWithRange(NSRange(location: 9, length: 1))
            var d2 = cpf.substringWithRange(NSRange(location: 10, length: 1))
            
            var temp1 = 0, temp2 = 0
            
            for i in 0...8 {
                
                var char = Int(cpf.substringWithRange(NSRange(location: i, length: 1)))
                
                temp1 += char! * (10 - i)
                temp2 += char! * (11 - i)
            }
            
            temp1 %= 11
            temp1 = temp1 < 2 ? 0 : 11-temp1
            
            temp2 += temp1 * 2
            temp2 %= 11
            temp2 = temp2 < 2 ? 0 : 11-temp2
            
            if temp1 == Int(d1) && temp2 == Int(d2) {
                return true
            }
            
        }
        
        return false
    }
 
}
