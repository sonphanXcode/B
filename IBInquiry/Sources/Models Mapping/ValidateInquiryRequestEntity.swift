//
//  ValidateInquiryRequestEntity.swift
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

public struct ValidateInquiryRequestEntity: Codable, Responseable, JSONEncodable, Hashable {

    public var inquiryReason: String?
    public var inquiryDesc: String?
    public var id: String?
    
}

extension ValidateInquiryRequestEntity: Emptyable {
    public static var empty: ValidateInquiryRequestEntity {
        return .init(inquiryReason: nil, inquiryDesc: nil, id: nil)
    }
}
