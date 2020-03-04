//
//  StringUtil.swift
//  foodScore2
//
//  Created by Tsai Meng Han on 2020/2/27.
//  Copyright © 2020 Tsai Meng Han. All rights reserved.
//

import Foundation


class MethodUtil{
    func isNotEmpty(Str:String?)->Bool{
        
        if let notNilStr = Str{
            //移除空白
            let newStr = notNilStr.trimmingCharacters(in: .whitespacesAndNewlines)
                   //無輸入
                   if newStr == "" {
                       return false
                   }
        }else{
            return false
        }
       
        return true
    }
    //檢核非空白,數字
    func isNumber(str:String?)->Bool{
        if let notnilStr = str{
            let scan:Scanner = Scanner(string: notnilStr)
            var val:Int = 0
            return scan.scanInt(&val) && scan.isAtEnd
        }else{
            return false
        }
               
               
           }
           func isNotNativeAndDecimal(num:Int)->Bool{
               
               return true
           }
    
    

}

