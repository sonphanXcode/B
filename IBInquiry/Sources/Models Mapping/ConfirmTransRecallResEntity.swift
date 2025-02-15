//
//  ConfirmTransRecallResEntity.swift
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
import IBFeatureCommon
#endif

/** Data */
public struct ConfirmTransRecallResEntity: Codable, Responseable, JSONEncodable, Hashable {

    public var transaction: TxnPaymentRecallEntity?
    public var successfulTransactions: [TransactionResDetailEntity]?
    public var failedTransactions: [TransactionResDetailEntity]?
    
}

extension ConfirmTransRecallResEntity: Emptyable {
    public static var empty: ConfirmTransRecallResEntity {
        return .init(transaction: nil, successfulTransactions: nil, failedTransactions: nil)
    }
}

extension ConfirmTransRecallResEntity {
    public init(from signingResult: SigningResult<TxnPaymentRecallEntity>?) {
        self.transaction = signingResult?.transInfo
        if let success = signingResult?.success as? [TransactionResDetailEntity], let failed = signingResult?.errors as? [TransactionResDetailEntity] {
            self.successfulTransactions = success
            self.failedTransactions = failed
        }
    }
}

extension ConfirmTransRecallResDto {
    func toEntity() -> ConfirmTransRecallResEntity {
        return ConfirmTransRecallResEntity(
            transaction: self.transaction?.toEntity(),
            successfulTransactions: self.successfulTransactions?.map { $0.toEntity() },
            failedTransactions: self.failedTransactions?.map { $0.toEntity() }
        )
    }
}
