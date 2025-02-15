//
//  TransactionDetailRow.swift
//  IBInquiry
//
//  Created by Son phan on 11/2/25.
//  Copyright © 2025 bidv.com. All rights reserved.
//

import SwiftUI
import IBResources

struct TransactionDetailRow: View {
    var title: String
    var value: String
    var isMoneyTransSum: Bool = false
    var isTotalTrans: Bool = false
    var isStatus: Bool = false
    
    @Environment(\.themeCoordinator) private var themeCoordinator
    
    init(title: String = "", value: String = "", isMoneyTransSum: Bool = false, isTotalTrans: Bool = false, isStatus: Bool = false) {
        self.title = title
        self.value = value
        self.isMoneyTransSum = isMoneyTransSum
        self.isTotalTrans = isTotalTrans
        self.isStatus = isStatus
       }
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack {
                Text(title)
                    .styleTypography(.bodyM)
                    .foregroundColor(themeCoordinator.color.contentMainTertiary)
            }
            .frame(maxWidth: 135.5, alignment: .leading)
            Spacer()
            if isTotalTrans {
                HStack {
                    IBResourcesAsset.fileXlsx.swiftUIImage.resizable().scaledToFit().frame(width: 18, height: 18)
                    Text(value)
                        .styleTypography(.titleS)
                        .foregroundColor(themeCoordinator.color.contentMainPrimary)
                    
                }
            } else if isStatus {
                VStack {
                    Text(value)
                        .styleTypography(.bodyM)
                        .foregroundColor(themeCoordinator.color.contentBrand01Primary)
                        .padding(.horizontal, .spacing.space2xs)
                        .padding(.vertical, .spacing.space3xs)
                }
                .background(themeCoordinator.color.bgBrand01Tertiary)
                .cornerRadius(.radius.m, corners: .allCorners)
            }
            
            else {
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
