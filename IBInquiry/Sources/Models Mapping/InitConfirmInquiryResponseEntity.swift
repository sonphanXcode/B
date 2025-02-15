//
//  InitConfirmInquiryResponseEntity.swift
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
public struct InitConfirmInquiryResponseEntity: Codable, Responseable, JSONEncodable, Hashable {

    public var transaction: TransactionInquiry?
    public var successfulTransactions: [TransactionResDetail]?
    public var failedTransactions: [TransactionResDetail]?

}

extension InitConfirmInquiryResponseEntity: Emptyable {
    public static var empty: InitConfirmInquiryResponseEntity {
        return .init(transaction: nil, successfulTransactions: nil, failedTransactions: nil)
    }
}
