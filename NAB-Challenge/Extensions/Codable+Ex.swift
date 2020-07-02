//
//  Codable+Ex.swift
//  NAB-Challenge
//
//  Created by Hoang Ta on 7/2/20.
//  Copyright © 2020 ht. All rights reserved.
//

import Foundation

extension Decoder {
  func decode<T: Decodable>(_ key: String, as type: T.Type = T.self) throws -> T {
    return try decode(AnyCodingKey(key), as: type)
  }

  func decode<T: Decodable, K: CodingKey>(_ key: K, as type: T.Type = T.self) throws -> T {
    let container = try self.container(keyedBy: K.self)
    return try container.decode(type, forKey: key)
  }
}

// MARK: - Private supporting types
private struct AnyCodingKey: CodingKey {
  var stringValue: String
  var intValue: Int?

  init(_ string: String) {
    stringValue = string
  }

  init?(stringValue: String) {
    self.stringValue = stringValue
  }

  init?(intValue: Int) {
    self.intValue = intValue
    self.stringValue = String(intValue)
  }
}
