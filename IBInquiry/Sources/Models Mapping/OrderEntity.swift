//
//  OrderEntity.swift
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

public struct OrderEntity: Codable, Responseable, JSONEncodable, Hashable {

    public var field: String?
    public var direction: String?
    
}

extension OrderEntity: Emptyable {
    public static var empty: OrderEntity {
        return .init(field: nil, direction: nil)
    }
}

extension OrderEntity {
    public func toDtoModel() -> Order {
        Order(field: self.field, direction: self.direction)
    }
}
