//
//  ApproveInquiryRequestEntity.swift
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

public struct ApproveInquiryRequestEntity: Codable, Responseable, JSONEncodable, Hashable {

    public var txnIds: [String]
    
}

extension ApproveInquiryRequestEntity: Emptyable {
    public static var empty: ApproveInquiryRequestEntity {
        return .init(txnIds: .empty)
    }
}
