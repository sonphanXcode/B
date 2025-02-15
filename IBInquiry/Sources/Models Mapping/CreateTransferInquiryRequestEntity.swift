//
//  CreateTransferInquiryRequestEntity.swift
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

public struct CreateTransferInquiryRequestEntity: Codable, Responseable, JSONEncodable, Hashable {

    public var id: String?
    
}

extension CreateTransferInquiryRequestEntity: Emptyable {
    public static var empty: CreateTransferInquiryRequestEntity {
        return .init(id: nil)
    }
}
