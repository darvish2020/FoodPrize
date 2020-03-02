//
//  StringUtil.swift
//  foodScore2
//
//  Created by Tsai Meng Han on 2020/2/27.
//  Copyright © 2020 Tsai Meng Han. All rights reserved.
//

import Foundation


class StringUtil{
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
}

