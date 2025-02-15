//
//  FilterEntity.swift
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

public struct FilterEntity: Codable, Responseable, JSONEncodable, Hashable {

    /** ct/ eq/ neq/ gt/ gte/ lt/ lte */
    public var _operator: String?
    public var field: String?
    public var value: String?
    
}

extension FilterEntity: Emptyable {
    public static var empty: FilterEntity {
        return .init(_operator: nil, field: nil, value: nil)
    }
}

extension FilterEntity {
    public func toDtoModel() -> Filter {
        Filter(_operator: self._operator, field: self.field, value: self.value)
    }
}
