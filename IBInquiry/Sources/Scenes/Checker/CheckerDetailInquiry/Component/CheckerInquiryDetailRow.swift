//
//  CheckerInquiryDetailRow.swift
//  IBInquiry
//
//  Created by tran dinh quy on 11/2/25.
//  Copyright © 2025 bidv.com. All rights reserved.
//

import SwiftUI
import IBResources

struct CheckerInquiryDetailRow: View {
    var title: String
    var value: String
    var valueColor: Color = .primary
    var isMoneyTransSum: Bool = false
    var isStatus: Bool = false
    var isTransaction: Bool = false
    
    @Environment(\.themeCoordinator) private var themeCoordinator
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
                .styleTypography(.bodyM)
                .foregroundColor(Color.neutral600)
            Spacer()
            if isStatus {
                VStack {
                    Text(value)
                        .styleTypography(.bodyM)
                        .foregroundColor(themeCoordinator.color.contentBrand01Primary)
                        .padding(.horizontal, .spacing.space2xs)
                        .padding(.vertical, .spacing.space3xs)
                }
                .background(themeCoordinator.color.bgBrand01Tertiary)
                .cornerRadius(.radius.m, corners: .allCorners)
            } else if isTransaction {
                HStack {
                    IBResourcesAsset.fileXlsx.swiftUIImage.resizable().scaledToFit().frame(width: 18, height: 18)
                    Text(value)
                        .styleTypography(.titleS)
                        .foregroundColor(themeCoordinator.color.contentMainPrimary)
                }
            } else {
                Text(value)
                    .align(.trailing)
                    .styleTypography(isMoneyTransSum ? .titleM : .titleS)
                    .foregroundColor(themeCoordinator.color.contentMainPrimary)
            }
        }
        .padding([.top, .bottom], .spacing.spaceXs)
        .padding([.leading, .trailing], .spacing.spaceM)
    }
}
