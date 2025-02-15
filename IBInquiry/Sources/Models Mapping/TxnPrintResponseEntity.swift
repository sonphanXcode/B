//
//  TxnPrintResponseEntity.swift
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

/** Data */
public struct TxnPrintResponseEntity: Codable, Responseable, JSONEncodable, Hashable {

    public var url: String?

}

extension TxnPrintResponseEntity: Emptyable {
    public static var empty: TxnPrintResponseEntity {
        return .init(url: nil)
    }
}

extension TxnPrintResponseDto {
    public func toEntity() -> TxnPrintResponseEntity {
        TxnPrintResponseEntity(url: self.url)
    }
}
