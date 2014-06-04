//
//  pointTests.swift
//  gameoflife
//
//  Created by Yonatan Bergman on 6/4/14.
//  Copyright (c) 2014 Yonatan Bergman. All rights reserved.
//

import XCTest

class pointTests: XCTestCase {

    func testPointsAreEqual() {
        XCTAssertEqual(Point(x: 0, y: 0), Point(x: 0, y: 0))
    }

    func testDifferentPointsAreUnequal() {
        XCTAssertNotEqual(Point(x: 1, y: 0), Point(x: 0, y: 0))
    }
    
    func testNeighboursCountEight() {
        XCTAssertEqual(Point(x: 0, y: 0).neighbours().count, 8)
    }

    func testNeighbours(){
        let srcPoint = Point(x: 1, y: 1)
        let neighbours = [Point(x: 0, y: 0), Point(x: 0, y: 1), Point(x: 0, y: 2),
                          Point(x: 1, y: 0), Point(x: 1, y: 2),
                          Point(x: 2, y: 0), Point(x: 2, y: 1), Point(x: 2, y: 2)]
        let calculatedNeighbours = srcPoint.neighbours()
        for idx in (0..neighbours.count){
            XCTAssertEqual(calculatedNeighbours[idx], neighbours[idx])
        }
    }

}
