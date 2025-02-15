//
//  InitTransConfirmEntity.swift
//  IBInquiry
//
//  Created by tran dinh quy on 10/2/25.
//  Copyright © 2025 bidv.com. All rights reserved.
//

import Foundation
import IBCommon
import IBFoundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct InitTransConfirmEntity: Codable, Responseable, JSONEncodable, Hashable {

    static let confirmValueRule = StringRule(minLength: 0, maxLength: 50, pattern: nil)
    public var transKey: String
    public var confirmValue: String?
    
}

extension InitTransConfirmEntity: Emptyable {
    public static var empty: InitTransConfirmEntity {
        return .init(transKey: .empty, confirmValue: nil)
    }
}
