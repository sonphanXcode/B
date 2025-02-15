//
//  TransactionInquiryEntity.swift
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

public struct TransactionInquiryEntity: Codable, Responseable, JSONEncodable, Hashable {

    public var orgTxnId: String?
    
}

extension TransactionInquiryEntity: Emptyable {
    public static var empty: TransactionInquiryEntity {
        return .init(orgTxnId: nil)
    }
}
