

import Foundation

enum Currency {
    
    static func ko(_ n: Int) -> String {
        var n = n
        var str = ""
        while n > 1000 {
            var temp = "\(n%1000)"
            temp = "," + temp + String(repeating: "0", count: 3-temp.count)
            str = temp + str
            n/=1000
        }
        str = "₩\(n)" + str
        return str
    }
}
