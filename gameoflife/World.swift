//
//  World.swift
//  gameoflife
//
//  Created by Yonatan Bergman on 6/4/14.
//  Copyright (c) 2014 Yonatan Bergman. All rights reserved.
//

import Foundation

class World {
    var aliveCells:Array<Point> = []
    
    
    func addCell(point:Point){
        self.aliveCells.append(point)
    }
    
    func tick(){
        var cellsWithNeighbours = countCellsWithNeighbours()
        var newCells:Array<Point> = []
        
        for cell in aliveCells{
            var count:Int? = cellsWithNeighbours.removeValueForKey(cell)
            if count && (count == 2 || count == 3){
                newCells.append(cell)
            }
        }
        for (cell, count) in cellsWithNeighbours {
            if count == 3 {
                newCells.append(cell)
            }
        }
        self.aliveCells = newCells;
    }
    
    func countCellsWithNeighbours() -> Dictionary<Point, Int> {
        var counterHash = initEmptyCounterHash()
        
        for cell in aliveCells{
            for neighbour in cell.neighbours(){
                if let currentCount = counterHash[neighbour]{
                    counterHash[neighbour] = currentCount + 1
                } else {
                    counterHash[neighbour] = 1
                }
            }
        }
        return counterHash

    }
    
    func initEmptyCounterHash() -> Dictionary<Point, Int>{
        var counter:Dictionary<Point, Int> = [:]
        for cell in aliveCells{
            counter[cell] = 0
        }
        return counter
    }
    
// ###### pragma mark - printing to console ######

    func isCellAlive(point: Point) -> Bool{
        for cell in aliveCells {
            if cell == point {
                return true
            }
        }
        return false
    }

    var bounds: Rect {
    let yPoints = aliveCells.map{$0.y}
        let minY = minElement(yPoints)
        let maxY = maxElement(yPoints)
        
        let xPoints = aliveCells.map{$0.x}
        let minX = minElement(xPoints)
        let maxX = maxElement(xPoints)
        return Rect(top: minY, left: minX, bottom: maxY, right: maxX)
    }
    
    func printWorld(){
        let b = self.bounds
        for y in (b.top...b.bottom){
            var line = ""
            for x in (b.left...b.right){
                line += self.printCell(Point(x: x, y: y))
            }
            println(line)
        }
    }
    
    func printCell(point: Point) -> String{
        if self.isCellAlive(point){
            return "X"
        } else {
            return "-"
        }
    }
    
}
