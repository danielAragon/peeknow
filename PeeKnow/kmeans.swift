//
//  kmeans.swift
//  PeeKnow
//
//  Created by Daniel Aragon Ore on 11/1/18.
//  Copyright © 2018 Daragonor. All rights reserved.
//

import Foundation

func select<T>(from a: [T], count requested: Int) -> [T] {
    var examined = 0
    var selected = 0
    var b = [T]()
    
    while selected < requested {                          // 1
        let r = Double(arc4random()) / 0x100000000          // 2
        
        let leftToExamine = a.count - examined              // 3
        let leftToAdd = requested - selected
        
        if Double(leftToExamine) * r < Double(leftToAdd) {  // 4
            selected += 1
            b.append(a[examined])
        }
        
        examined += 1
    }
    return b
}
let centerEnum = ["noColor" : 15724785,
                  "paleStraw" : 16052954,
                  "transpYellow" : 15723713,
                  "darkYellow" : 15723685,
                  "amber" : 14797196,
                  "brown" : 11313020,
                  "pink" : 14061176,
                  "orange" : 14985312,
                  "bluegreen" : 9159046,
                  "foaming" : 14474619]
func kMeans(numCenters: Int, convergeDistance: Int, points: [Int]) -> [Int] {
    
    // Randomly take k objects from the input data to make the initial centroids.
    var centers = select(from: points, count: numCenters)
    
    // This loop repeats until we've reached convergence, i.e. when the centroids
    // have moved less than convergeDistance since the last iteration.
    var centerMoveDist = 0
    var counter = 0
    repeat {
        // In each iteration of the loop, we move the centroids to a new position.
        // The newCenters array contains those new positions.
        var newCenters = [Int](repeating: 0, count: numCenters)
        
        // We keep track of how many data points belong to each centroid, so we
        // can calculate the average later.
        var counts = [Int](repeating: 0, count: numCenters)
        
        // For each data point, find the centroid that it is closest to. We also
        // add up the data points that belong to that centroid, in order to compute
        // that average.
        for p in points {
            var min = 1000000000000000
            var index = 0
            for (i, center) in centers.enumerated(){
                
                var distance = center - p
                if distance < 0{
                    distance = distance * -1
                }
                if distance < min{
                    min = distance
                    index = i
                }
            }
//            let c = indexOfNearestCenter(p, centers: centers)
            newCenters[index] += p
            counts[index] += 1
        }
        
    // Take the average of all the data points that belong to each centroid.
    // This moves the centroid to a new position.
    for idx in 0..<numCenters {
        if counts[idx] != 0{
            newCenters[idx] /= counts[idx]
        }
    }

    // Find out how far each centroid moved since the last iteration. If it's
    // only a small distance, then we're done.
    centerMoveDist = 0
    for idx in 0..<numCenters {
        centerMoveDist += centers[idx] - newCenters[idx]
    }
    
    centers = newCenters
        var minCenter = 1000000000000000
        for (i, center) in centers.enumerated(){
            for (_,color) in centerEnum{
                var distance = center - color
                if distance < 0{
                    distance = distance * -1
                }
                if distance < minCenter{
                    minCenter = distance
                    centers[i] = color
                }
            }
        }
        counter += 1
    } while centerMoveDist > Int(convergeDistance) && counter < 1000

  return centers
}
