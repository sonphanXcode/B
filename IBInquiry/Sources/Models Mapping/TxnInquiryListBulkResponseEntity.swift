//
//  TxnInquiryListBulkResponseEntity.swift
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

/** List data */
public struct TxnInquiryListBulkResponseEntity: Codable, Responseable, JSONEncodable, Hashable {

    public var id: String?
    public var benAccNo: String?
    public var benName: String?
    public var type: String?
    public var cardNo: String?
    public var effDate: String?
    public var status: String?
    public var amount: Double?
    public var ccy: String?

}

extension TxnInquiryListBulkResponseEntity: Emptyable {
    public static var empty: TxnInquiryListBulkResponseEntity {
        return .init(id: nil, benAccNo: nil, benName: nil, type: nil, cardNo: nil, effDate: nil, status: nil, amount: nil, ccy: nil)
    }
}

extension TxnInquiryListBulkResponseDto {
    public func toEntity() -> TxnInquiryListBulkResponseEntity {
        return TxnInquiryListBulkResponseEntity(
            id: self.id,
            benAccNo: self.benAccNo,
            benName: self.benName,
            type: self.type,
            cardNo: self.cardNo,
            effDate: self.effDate,
            status: self.status,
            amount: self.amount,
            ccy: self.ccy
        )
    }
}
