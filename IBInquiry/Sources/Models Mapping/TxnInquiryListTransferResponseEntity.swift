//
//  TxnInquiryListTransferResponseEntity.swift
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
public struct TxnInquiryListTransferResponseEntity: Codable, Responseable, JSONEncodable, Hashable {

    public var id: String?
    public var benBankNameShort: String?
    public var benAccNo: String?
    public var benName: String?
    public var txnType: String?
    public var cardNo: String?
    public var effDate: String?
    public var status: String?
    public var amount: Double?
    public var ccy: String?
    public var benId: String?

}

extension TxnInquiryListTransferResponseEntity: Emptyable {
    public static var empty: TxnInquiryListTransferResponseEntity {
        return .init(id: nil, benBankNameShort: nil, benAccNo: nil, benName: nil, txnType: nil, cardNo: nil, effDate: nil, status: nil, amount: nil, ccy: nil, benId: nil)
    }
}

extension TxnInquiryListTransferResponseDto {
    public func toEntity() -> TxnInquiryListTransferResponseEntity {
        return TxnInquiryListTransferResponseEntity(
            id: self.id,
            benBankNameShort: self.benBankNameShort,
            benAccNo: self.benAccNo,
            benName: self.benName,
            txnType: self.txnType,
            cardNo: self.cardNo,
            effDate: self.effDate,
            status: self.status,
            amount: self.amount,
            ccy: self.ccy,
            benId: self.benId
        )
    }
}
