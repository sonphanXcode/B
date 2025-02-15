//
//  DataListTxnInquiryListBulkResponseEntity.swift
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
public struct DataListTxnInquiryListBulkResponseEntity: Codable, Responseable, JSONEncodable, Hashable {

    /** List data */
    public var items: [TxnInquiryListBulkResponseEntity]?
    /** Total size */
    public var total: Int64?
    
}

extension DataListTxnInquiryListBulkResponseEntity: Emptyable {
    public static var empty: DataListTxnInquiryListBulkResponseEntity {
        return .init(items: nil, total: nil)
    }
}

extension DataListTxnInquiryListBulkResponseDto {
    public func toEntity() -> DataListTxnInquiryListBulkResponseEntity {
        let items: [TxnInquiryListBulkResponseEntity]? = self.items?.map { $0.toEntity() }
        return DataListTxnInquiryListBulkResponseEntity(items: items, total: self.total)
    }
}
