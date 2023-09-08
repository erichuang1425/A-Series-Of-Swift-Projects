import Foundation

var width:Float = 3.4

var height:Float = 2.1

var bucketsOfPaint:Int{
    get{
        return Int(ceilf(width*height/1.5))
    }
    set{
        let areaCovered = Double(newValue)*1.5
        print("This amount of buckets can cover an area of \(areaCovered).")
    }
}
bucketsOfPaint = 4
print(bucketsOfPaint)
