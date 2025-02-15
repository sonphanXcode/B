//
//  ExtensionIBSelectedDataView.swift
//  IBInquiry
//
//  Created by Son phan on 9/2/25.
//  Copyright © 2025 bidv.com. All rights reserved.
//

import IBFoundation
import Foundation
import NavigationCoordinator
import SwiftUI
import MemberwiseInit
import IBDeepLinks
import IBViewComponents
import IBFeatureCommon
import IBResources
import SwiftMacro

extension IBSelectedDataView where Input == String, Output == CategoryResponseEntity, Content == ReasonManagerInquiryItem {
    public static func selectInquiryReasonEffector(envi: IBInquiryEnviromentProtocol?, categoryType: CategoryType) -> Effector<SelectedCommand<String>, SelectedAction<CategoryResponseEntity>> {
        return .init { command in
            switch command {
            case .getData:
                let type = categoryType.rawValue
                guard let result = await envi?.getCategoriesByType(request: CategoryRequestEntity(categoryType: [type])) else {
                    return .items([])
                }
                return result.fold(
                    { value in .items(value) },
                    { _ in .items([]) }
                )
            }
        }
    }
    
    public static func inquirySelectReason(
        result: @escaping (CategoryResponseEntity) -> Void,
        selectedItem: CategoryResponseEntity?
    )
    -> some View {
        IBSelectedDataView
            .with(
                title: IBResourcesStrings.lyDo,
                placeholder: IBResourcesStrings.timKiem,
                selectedItem: selectedItem,
                isAutoSelected: false,
                effector: selectInquiryReasonEffector(envi: DIContainer.standard.resolve(type: IBInquiryEnviromentProtocol.self), categoryType: .inquiryReason),
                onSelectItem: { value in
                    result(value)
                },
                filter: { _, _ in true },
                searchEnable: { _ in false },
                itemView: { item, isSelected in
                    ReasonManagerInquiryItem(item: item.name ?? "", isSelected: isSelected)
                }
            )
    }
    
    public static func inquirySelectType(
        result: @escaping (CategoryResponseEntity) -> Void,
        selectedItem: CategoryResponseEntity?
    )
    -> some View {
        IBSelectedDataView
            .with(
                title: IBResourcesStrings.lyDo,
                placeholder: IBResourcesStrings.timKiem,
                selectedItem: selectedItem,
                isAutoSelected: false,
                effector: selectInquiryReasonEffector(envi: DIContainer.standard.resolve(type: IBInquiryEnviromentProtocol.self), categoryType: .txnType),
                onSelectItem: { value in
                    result(value)
                },
                filter: { _, _ in true },
                searchEnable: { _ in false },
                itemView: { item, isSelected in
                    ReasonManagerInquiryItem(item: item.name ?? "", isSelected: isSelected)
                }
            )
    }
}
