//
//  ReasonManagerInquiryItem.swift
//  IBInquiry
//
//  Created by Son phan on 10/2/25.
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

public struct ReasonManagerInquiryItem: View {
    @Environment(\.themeCoordinator) var themeCoordinator
    var item: String
    var isSelected: Bool
    
    public init(item: String, isSelected: Bool) {
        self.item = item
        self.isSelected = isSelected
    }
    
    public var body: some View {
        HStack(spacing: .spacing.spaceXs) {
            Text(item)
                .styleTypography(.bodyM)
                .foregroundColor(themeCoordinator.color.contentMainPrimary)
                .greedyWidth(.leading)
            
            if isSelected {
                IBResourcesAsset.check.swiftUIImage
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 17, height: 17)
                    .foregroundColor(themeCoordinator.color.contentBrand01Primary)
            }
        }
        .padding(.trailing, .spacing.spaceS)
        .padding(.vertical, .spacing.spaceS)
        .padding(.leading, .spacing.spaceXs)
        .greedyWidth(.leading)
        .background(
            isSelected ? themeCoordinator.color.bgBrand01Tertiary : .clear
        )
        .cornerRadius(.radius.m)
    }
}

