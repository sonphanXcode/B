//
//  DtoMapper.swift
//  IBInquiry
//
//  Created by tran dinh quy on 8/2/25.
//  Copyright © 2025 bidv.com. All rights reserved.
//

import Foundation
import IBFoundation

public struct DtoMapper {
    public static func map<T: Decodable>(_ dto: Any, to type: T.Type) -> T? {
        do {
            let jsonData: Data
            if let jsonString = dto as? String,
               let data = jsonString.data(using: .utf8) {
                jsonData = data
            } else if let jsonObject = dto as? [String: Any] {
                jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
            } else if let jsonArray = dto as? [Any] {
                jsonData = try JSONSerialization.data(withJSONObject: jsonArray, options: [])
            } else {
                return nil
            }
            
            let decodedObject = try JSONDecoder().decode(T.self, from: jsonData)
            return decodedObject
        } catch let DecodingError.typeMismatch(type, context) {
            AppLogger.share.log("Type mismatch for type: \(type) - \(context.debugDescription))")
            
        } catch let DecodingError.valueNotFound(type, context) {
            AppLogger.share.log("Value not found for type: \(type) - \(context.debugDescription)")
        } catch let DecodingError.keyNotFound(key, context) {
            AppLogger.share.log("Key not found: \(key) - \(context.debugDescription)")
        } catch {
            AppLogger.share.log("Unexpected error during decoding: \(error)")
        }
        return nil
    }
}
