//
//  DataListTxnInquiryResponseEntity.swift
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
public struct DataListTxnInquiryResponseEntity: Codable, Responseable, JSONEncodable, Hashable {

    /** List data */
    public var items: [TxnInquiryResponseEntity]?
    /** Total size */
    public var total: Int64?
    
}

extension DataListTxnInquiryResponseEntity: Emptyable {
    public static var empty: DataListTxnInquiryResponseEntity {
        return .init(items: nil, total: nil)
    }
}
