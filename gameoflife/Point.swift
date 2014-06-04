//
//  point.swift
//  gameoflife
//
//  Created by Yonatan Bergman on 6/4/14.
//  Copyright (c) 2014 Yonatan Bergman. All rights reserved.
//

import Foundation

struct Point : Hashable, Equatable {
    var x:Int = 0
    var y:Int = 0
    
    var hashValue: Int {
        return x * 10000 + y
    }
    
    // Get the surrounding cells around this point
    func neighbours() -> Array<Point>{
        var result:Array<Point> = []
        for xModifier in (-1...1){
            for yModifier in (-1...1){
                if xModifier != 0 || yModifier != 0 {
                    result.append(Point(x: self.x + xModifier, y: self.y + yModifier))
                }
            }
        }
        return result
    }
}

func ==(lhs: Point, rhs: Point) -> Bool{
    return lhs.x == rhs.x && lhs.y == rhs.y
}
