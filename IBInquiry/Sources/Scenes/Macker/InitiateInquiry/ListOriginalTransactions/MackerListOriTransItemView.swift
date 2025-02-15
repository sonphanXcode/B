//
//  MackerListOriTransItemView.swift
//  IBInquiry
//
//  Created by Son phan on 14/2/25.
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

struct MackerListOriTransItemView: SeletedableView {
    
    init(transaction: SelectedItem<MackerListInquiryItemModel>, selected: SelectedFunction<MackerListInquiryItemModel>?, itemAction: SelectedFunction<MackerItemAction<MackerListInquiryItemModel>>? ) {
        self.transaction = transaction
        self.selected = selected
        isChecked = transaction.isSelected
        self.itemAction = itemAction
    }
    
    @State var isChecked: Bool
    @State private var isShowingTransReturnView: Bool = false
    
    @Environment(\.navigationCoordinator) private var navigation
    @Environment(\.themeCoordinator) private var themCoordinator
    
    var transaction: SelectedItem<MackerListInquiryItemModel>
    let selected: SelectedFunction<MackerListInquiryItemModel>?
    let itemAction: ((MackerItemAction<MackerListInquiryItemModel>) -> Void)?
        
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    Button(
                        action: {
                            selected?(transaction.rawData)
                        },
                        label: {
                            IBCheckbox(isChecked: .constant(transaction.isSelected)).allowsHitTesting(false)
                        }
                    )
                    .padding(.leading, 16)
                    
                    Text(transaction.rawData.id ?? "")
                        .styleTypography(.titleS)
                        .padding(.leading, .spacing.spaceXs)
                        .foregroundColor(themCoordinator.color.contentMainPrimary)
                    
                    transactionStatus
                        .padding(.leading, .spacing.spaceXs)
                    Spacer()
                    Button {
                        isShowingTransReturnView.toggle()
                    } label: {
                        IBResourcesAsset.moreVerticalOutline.swiftUIImage
                            .resizable()
                            .scaledToFill()
                            .frame(20, 20)
                            .padding(.trailing, 14)
                    }
                }
                
                Divider()
                    .padding(.top, 12)
                
                transItemContent
                    .padding(.leading, 16)
                    .padding(.top, 12)
            }
            .greedyWidth()
            .height(128)
            .backgroundColor(themCoordinator.color.bgMainSecondaryHover)
            .cornerRadius(8, corners: .allCorners)
            .padding(.vertical, 4)
            .eraseToAnyView()
            
            if isShowingTransReturnView {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isShowingTransReturnView = false
                    }
                transPoppupMaker
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 8)
                    .padding(.top, 8)
            }
        }
        .onTapGesture {
            navigation.execute(.navigate(IBInquiryRoute.mackerDetailTransInquiry(transId: transaction.rawData.id ?? "", detailType: TransInquiryType(rawValue: transaction.rawData.txnType ?? "") ?? .single), animated: true))
        }
    }
    
    @MainActor
    private var transactionStatus: some View {
        VStack {
            Text(TransactionInquiryStatus(rawValue: transaction.rawData.status?.rawValue ?? "")?.status ?? "")
                .padding(EdgeInsets(3, 3, 3, 3))
                .styleTypography(.bodyS)
                .background(themCoordinator.color.bgBrand01Tertiary)
                .foregroundColor(themCoordinator.color.contentBrand01Primary)
                .cornerRadius(4, corners: .allCorners)
            
        }
    }
    
    @MainActor
    private var transItemContent: some View {
        VStack(spacing: 4) {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(InquiryReasonCodeType(rawValue: transaction.rawData.inquiryReason ?? "")?.reasonType ?? "")
                        .styleTypography(.titleS)
                        .foregroundColor(themCoordinator.color.contentMainPrimary)
                }
                Spacer()
            }
            HStack(spacing: 0) {
                Text(TransInquiryType(rawValue: transaction.rawData.txnType ?? "")?.type ?? "")
                    .styleTypography(.bodyM)
                    .foregroundColor(themCoordinator.color.contentMainTertiary)
                
                Spacer()
            }
            HStack(spacing: 0) {
                Text("\(transaction.rawData.amount?.formattedCurrency(transaction.rawData.ccy)) \(transaction.rawData.ccy)")
                    .styleTypography(.titleS)
                    .foregroundColor(themCoordinator.color.contentMainPrimary)
                Spacer()
                IBResourcesAsset.calendarOutline.swiftUIImage
                    .resizable()
                    .scaledToFill()
                    .frame(12, 12)
                    .padding(.trailing, 4)
                Text(transaction.rawData.createdDate ?? "")
                    .styleTypography(.bodyM)
                    .padding(.trailing, 16)
                    .foregroundColor(themCoordinator.color.contentMainTertiary)
            }
        }
    }
    
    @MainActor
    private var transPoppupMaker: some View {
        Button(action: {
            itemAction?(.export(transaction.rawData))
        }, label: {
            HStack {
                IBResourcesAsset.traSoat.swiftUIImage
                    .resizable()
                    .scaledToFill()
                    .frame(20, 20)
                    .padding(.trailing, 4)
                Text(IBResourcesStrings.traSoat)
                    .styleTypography(.bodyM)
                    .foregroundColor(themCoordinator.color.contentMainSecondary)
            }
        }).frame(width: 112, height: 44, alignment: .center)
            .background(themCoordinator.color.bgMainTertiary)
            .cornerRadius(8.0)
            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
      
    }
}
