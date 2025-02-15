//
//  ResponseErrorEntity.swift
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

/** Addition Error List */
public struct ResponseErrorEntity: Codable, Responseable, JSONEncodable, Hashable {

    public var errorCode: String?
    public var errorDesc: String?
    public var refVal: AnyCodable?
    
}

extension ResponseErrorEntity: Emptyable {
    public static var empty: ResponseErrorEntity {
        return .init(errorCode: nil, errorDesc: nil, refVal: nil)
    }
}
