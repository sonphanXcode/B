//
//  CategoryResponseEntity.swift
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
public struct CategoryResponseEntity: Codable, Responseable, JSONEncodable, Hashable {

    public var code: String?
    public var name: String?
    public var type: String?
    
}

extension CategoryResponseEntity: Emptyable {
    public static var empty: CategoryResponseEntity {
        return .init(code: nil, name: nil, type: nil)
    }
}

public extension CategoryResponseDto {
    func toEntity() -> CategoryResponseEntity {
        return CategoryResponseEntity(
            code: self.code,
            name: self.name,
            type: self.type
        )
    }
}
