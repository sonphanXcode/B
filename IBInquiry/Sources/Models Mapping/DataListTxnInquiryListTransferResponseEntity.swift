//
//  DataListTxnInquiryListTransferResponseEntity.swift
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
public struct DataListTxnInquiryListTransferResponseEntity: Codable, Responseable, JSONEncodable, Hashable {

    /** List data */
    public var items: [TxnInquiryListTransferResponseEntity]?
    /** Total size */
    public var total: Int64?
    
}

extension DataListTxnInquiryListTransferResponseEntity: Emptyable {
    public static var empty: DataListTxnInquiryListTransferResponseEntity {
        return .init(items: nil, total: nil)
    }
}

extension DataListTxnInquiryListTransferResponseDto {
    func toEntity() -> DataListTxnInquiryListTransferResponseEntity {
        return DataListTxnInquiryListTransferResponseEntity(
            items: self.items?.map { $0.toEntity() },
            total: self.total
        )
    }
}
