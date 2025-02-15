//
//  TransactionResDetailEntity.swift
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

public struct TransactionResDetailEntity: Codable, Responseable, JSONEncodable, Hashable {

    public var txnId: String
    public var message: String
    
}

extension TransactionResDetailEntity: Emptyable {
    public static var empty: TransactionResDetailEntity {
        return .init(txnId: .empty, message: .empty)
    }
}

extension TransactionResDetail {
    func toEntity() -> TransactionResDetailEntity {
        return TransactionResDetailEntity(
            txnId: self.txnId,
            message: self.message
        )
    }
}
