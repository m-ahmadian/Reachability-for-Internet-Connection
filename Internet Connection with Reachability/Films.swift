//
//  Films.swift
//  Internet Connection with Reachability
//
//  Created by Mehrdad Ahmadian on 2021-12-29.
//

import Foundation

struct Films: Decodable {
  let count: Int
  let all: [Film]

  enum CodingKeys: String, CodingKey {
    case count
    case all = "results"
  }
}
