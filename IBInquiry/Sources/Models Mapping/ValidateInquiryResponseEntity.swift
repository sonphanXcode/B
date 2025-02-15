//
//  ValidateInquiryResponseEntity.swift
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
public struct ValidateInquiryResponseEntity: Codable, Responseable, JSONEncodable, Hashable {

    public var feeTotal: Double?
    public var id: String?
    public var validateInquiryResponse: String?

}

extension ValidateInquiryResponseEntity: Emptyable {
    public static var empty: ValidateInquiryResponseEntity {
        return .init(feeTotal: nil, id: nil, validateInquiryResponse: nil)
    }
}
