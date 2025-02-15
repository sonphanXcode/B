//
//  TxnPaymentRecallEntity.swift
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

public struct TxnPaymentRecallEntity: Codable, Responseable, JSONEncodable, Hashable {

    public var id: String?
    public var txnId: String?
    public var totalRow: Int64?
    public var totalAmountText: String?
    public var amount: Double?
    public var ccy: String?
    
}

extension TxnPaymentRecallEntity: Emptyable {
    public static var empty: TxnPaymentRecallEntity {
        return .init(id: nil, txnId: nil, totalRow: nil, totalAmountText: nil, amount: nil, ccy: nil)
    }
}

extension TxnPaymentRecallDto {
    func toEntity() -> TxnPaymentRecallEntity {
        return TxnPaymentRecallEntity(
            id: self.id,
            txnId: self.txnId,
            totalRow: self.totalRow,
            totalAmountText: self.totalAmountText,
            amount: self.amount,
            ccy: self.ccy
        )
    }
}
