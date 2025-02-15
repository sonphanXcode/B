//
//  CategoryRequestEntity.swift
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

public struct CategoryRequestEntity: Codable, Responseable, JSONEncodable, Hashable {

    public var categoryType: [String]
    
}

extension CategoryRequestEntity: Emptyable {
    public static var empty: CategoryRequestEntity {
        return .init(categoryType: .empty)
    }
}

extension CategoryRequestEntity {
    public func toCategoryRequestDto() -> CategoryRequestDto {
        CategoryRequestDto(categoryType: self.categoryType)
    }
}
