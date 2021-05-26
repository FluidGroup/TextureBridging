//
//  Logger.swift
//  TextureBridging
//
//  Created by muukii on 2019/05/15.
//  Copyright © 2019 muukii. All rights reserved.
//

import Foundation

enum Log {
  
  static func debug(_ items: Any...) {
    #if DEBUG
    print("TextureBirding::", items)
    #endif
  }
}
