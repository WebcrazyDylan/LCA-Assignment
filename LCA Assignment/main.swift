//
//  main.swift
//  LCA Assignment
//
//  Created by Dylan Park on 2021-08-18.
//

import Foundation

var alreadyExist = [Int:Bool]()
var children: [[Int]] = []

func lowestCommonAncestor() {
    print("Please input vertices for lowestCommonAncestor")
    
    let preN = readLine()!.split(separator: " ").map { Int($0) }
    let n = preN[0]!
    children = Array(repeating: Array(repeating: 0, count: 0), count: n + 1)
    alreadyExist[1] = true
    for i in 2...n {
        alreadyExist[i] = false
    }
    
    for _ in 0..<n - 1 {
        
        let nodeInfo = readLine()!.split(separator: " ").map { Int($0) }
        
        if alreadyExist[nodeInfo[0]!] == false {
            children[nodeInfo[1]!].append(nodeInfo[0]!)
            alreadyExist[nodeInfo[0]!] = true
        }
        if alreadyExist[nodeInfo[1]!] == false {
            children[nodeInfo[0]!].append(nodeInfo[1]!)
            alreadyExist[nodeInfo[1]!] = true
        }
    }
    
    let preM = readLine()!.split(separator: " ").map { Int($0) }
    let m = preM[0]!
    
    for _ in 0..<m {
        let nodeInfo = readLine()!.split(separator: " ").map { Int($0) }
        let p = nodeInfo[0]!
        let q = nodeInfo[1]!
        let LCA = lcaHelper(root: 1, p: p, q: q)!
        print("Lowest Common Ancestor of \(p) and \(q) is \(LCA).")
    }
}


func lcaHelper(root: Int, p: Int, q: Int) -> Int? {
    
    if root == p || root == q {
        // the root is the LCA
        return root
    }
    if children[root].isEmpty {
        // this root node is the dead end
        return nil
    }
    var count = 0
    var onlyFoundOne = 0
    for i in children[root] {
        if lcaHelper(root: i, p: p, q: q) != nil {
            onlyFoundOne = lcaHelper(root: i, p: p, q: q)!
            count += 1
        }
    }
    if count == 2 {
        // the root is the LCA
        return root
    } else if count == 1 {
        // LCA exists higher than this
        return onlyFoundOne
    } else {
        // nothing below this root node
        return nil
    }
}

lowestCommonAncestor()

/*
 Sample Input1
 15
 1 2
 1 3
 2 4
 3 7
 6 2
 3 8
 4 9
 2 5
 5 11
 7 13
 10 4
 11 15
 12 5
 14 7
 6
 6 11
 10 9
 2 6
 7 6
 8 13
 8 15
 Sample Output1
 2
 4
 2
 1
 3
 1
 */
