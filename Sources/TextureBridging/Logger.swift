
import Foundation
import os

enum Log {
  
  static func debug(_ log: OSLog, _ object: Any...) {
    os_log("%@", log: log, type: .debug, object.map { "\($0)" }.joined(separator: " "))
  }

}

extension OSLog {

  static let generic: OSLog = {
    if ProcessInfo().environment["TEXTURE_BRIDGING_LOG"] != nil {
      return OSLog.init(subsystem: "TextureBridging", category: "Generic")
    } else {
      return .disabled
    }
  }()

}
