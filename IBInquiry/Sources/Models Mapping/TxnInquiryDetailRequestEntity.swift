//
//  TxnInquiryDetailRequestEntity.swift
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

public struct TxnInquiryDetailRequestEntity: Codable, Responseable, JSONEncodable, Hashable {

    static let idRule = StringRule(minLength: 0, maxLength: 50, pattern: nil)
    public var id: String
    
}

extension TxnInquiryDetailRequestEntity: Emptyable {
    public static var empty: TxnInquiryDetailRequestEntity {
        return .init(id: .empty)
    }
}
