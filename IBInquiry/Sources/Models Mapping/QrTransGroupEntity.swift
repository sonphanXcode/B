//
//  QrTransGroupEntity.swift
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

public struct QrTransGroupEntity: Codable, Responseable, JSONEncodable, Hashable {

    /** CCY */
    public var ccy: String?
    /** amount */
    public var amount: String?
    /** amountText */
    public var amountText: String?
    /** total */
    public var total: String?

}

extension QrTransGroupEntity: Emptyable {
    public static var empty: QrTransGroupEntity {
        return .init(ccy: nil, amount: nil, amountText: nil, total: nil)
    }
}

extension QrTransGroupDto {
    func toEntity() -> QrTransGroupEntity {
        return QrTransGroupEntity(
            ccy: self.ccy,
            amount: self.amount,
            amountText: self.amountText,
            total: self.total
        )
    }
}
