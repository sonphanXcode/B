//
//  RejectTransactionEntity.swift
//  IBInquiry
//
//  Created by tran dinh quy on 11/2/25.
//  Copyright © 2025 bidv.com. All rights reserved.
//

import Foundation
import IBCommon
import IBFoundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct RejectTransactionEntity: Codable, Responseable, JSONEncodable, Hashable {

    public var txnIds: [String]
    public var rejectReason: String?
    
}

extension RejectTransactionEntity: Emptyable {
    public static var empty: RejectTransactionEntity {
        return .init(txnIds: .empty, rejectReason: nil)
    }
}

