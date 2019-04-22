//
//  Contries.swift
//  SCBoy
//
//  Created by virus1994 on 2019/4/22.
//  Copyright © 2019 ascp. All rights reserved.
//

import UIKit
import SwiftyJSON

let contries : JSON = {
    let path = Bundle.main.url(forResource: "countries", withExtension: "json")!
    return try! JSON(data: Data(contentsOf: path))
}()

let contriesMap : [String:Int] = {
    var dic = [String:Int]()
    contries.arrayValue.enumerated().map({ ($0.element["code2l"].stringValue, $0.offset) }).forEach({ dic[$0.0] = $0.1 })
    return dic
}()

protocol Contries {
    
}

extension Contries {
    func image(forContry contry: String) -> UIImage? {
        guard let m = contriesMap[contry] else {
            return nil
        }

        return UIImage(named: contries[m]["flag_32"].stringValue)
    }
}
