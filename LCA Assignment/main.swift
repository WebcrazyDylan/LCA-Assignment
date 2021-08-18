//
//  main.swift
//  LCA Assignment
//
//  Created by Dylan Park on 2021-08-18.
//

import Foundation

func lca() {
  let n = Int(readLine()!)!
  var adj = [[Int]](repeating: [], count: n + 1)
  var depth = [Int](repeating: 0, count: n + 1)
  var parent = [Int](repeating: 0, count: n + 1)
  var check = [Bool](repeating: false, count: n + 1)
  
  for _ in 0..<n-1 {
    let edge = readLine()!.split(separator: " ").map { Int($0)! }
    let u = edge[0]
    let v = edge[1]
    adj[u].append(v)
    adj[v].append(u)
  }
  
  // preprocessing
  depth[1] = 0
  check[1] = true
  let q = Queue<Int>()
  q.enqueue(item: 1)
  
  while !q.isEmpty() {
    let u = q.dequeue()!
    for v in adj[u] {
      if !check[v] {
        depth[v] = depth[u] + 1
        parent[v] = u
        check[v] = true
        q.enqueue(item: v)
      }
    }
  }
  
  var m = Int(readLine()!)!
  while m > 0 {
    let nodes = readLine()!.split(separator: " ").map { Int($0)! }
    var x = nodes[0]
    var y = nodes[1]
    if depth[x] < depth[y] {
      swap(&x, &y)
    }
    while depth[x] != depth[y] {
      x = parent[x]
    }
    while x != y {
      x = parent[x]
      y = parent[y]
    }
    print(x)
    m -= 1
  }
}



lca()

