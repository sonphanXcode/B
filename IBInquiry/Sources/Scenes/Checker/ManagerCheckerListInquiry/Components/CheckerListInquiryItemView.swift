//
//  CheckerListInquiryItemView..swift
//  IBInquiry
//
//  Created by tran dinh quy on 7/2/25.
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

struct CheckerListInquiryItemView: SeletedableView {
    
    init(transaction: SelectedItem<CheckerListInquiryItemModel>, selected: SelectedFunction<CheckerListInquiryItemModel>?, itemAction: SelectedFunction<MackerItemAction<CheckerListInquiryItemModel>>? ) {
        self.transaction = transaction
        self.selected = selected
        isChecked = transaction.isSelected
        self.itemAction = itemAction
    }
    
    @State var isChecked: Bool
    @State private var isShowingTransReturnView: Bool = false
    
    @Environment(\.navigationCoordinator) private var navigation
    @Environment(\.themeCoordinator) private var themCoordinator
    
    var transaction: SelectedItem<CheckerListInquiryItemModel>
    let selected: SelectedFunction<CheckerListInquiryItemModel>?
    let itemAction: ((MackerItemAction<CheckerListInquiryItemModel>) -> Void)?
    
    var body: some View {
        ZStack {
            VStack(spacing: .spacing.spaceNone) {
                HStack {
                    Button(
                        action: {
                            selected?(transaction.rawData)
                        },
                        label: {
                            IBCheckbox(isChecked: .constant(transaction.isSelected)).allowsHitTesting(false)
                        }
                    )
                    .padding(.leading, .spacing.spaceM)
                    
                    Text(transaction.rawData.id)
                        .styleTypography(.titleS)
                        .padding(.leading, .spacing.spaceXs)
                        .foregroundColor(themCoordinator.color.contentMainPrimary)
                    Spacer()
                    Button {
                        isShowingTransReturnView.toggle()
                    } label: {
                        IBResourcesAsset.moreVerticalOutline.swiftUIImage
                            .resizable()
                            .scaledToFill()
                            .frame(20, 20)
                            .padding(.trailing, .spacing.spaceS)
                    }
                }
                
                Divider()
                    .padding(.top, .spacing.spaceS)
                
                transItemContent
                    .padding(.leading, .spacing.spaceM)
                    .padding(.top, .spacing.spaceS)
            }
            .greedyWidth()
            .height(128)
            .backgroundColor(themCoordinator.color.bgMainSecondaryHover)
            .cornerRadius( .radius.l, corners: .allCorners)
            .padding(.vertical, .spacing.space2xs)
            .eraseToAnyView()
            
            if isShowingTransReturnView {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isShowingTransReturnView = false
                    }
                transPoppupChecker
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, .spacing.spaceXs)
                    .padding(.top, .spacing.space5xl)
            }
        }
        .onTapGesture {
            let id = transaction.rawData.id
            navigation.execute(.navigate(IBInquiryRoute.inquiryTransactionDetailChecker(id: id, detailType: TransInquiryType(rawValue: transaction.rawData.txnType) ?? .single), animated: true))
        }
    }
    
    @MainActor
    private var transItemContent: some View {
        VStack(spacing: .spacing.space2xs) {
            HStack(spacing: .spacing.spaceNone) {
                VStack(alignment: .leading, spacing: .spacing.space2xs) {
                    Text(InquiryReasonCodeType(rawValue: transaction.rawData.inquiryReason)?.reasonType ?? "")
                        .styleTypography(.titleS)
                        .foregroundColor(themCoordinator.color.contentMainPrimary)
                    Text(TransInquiryType(rawValue: transaction.rawData.txnType)?.type ?? "")
                        .styleTypography(.bodyM)
                        .foregroundColor(themCoordinator.color.contentMainTertiary)
                }
                Spacer()
            }
            HStack(spacing: .spacing.spaceNone) {
                Text("\(transaction.rawData.amount.formattedCurrency(transaction.rawData.ccy)) \(transaction.rawData.ccy)")
                    .styleTypography(.titleS)
                    .foregroundColor(themCoordinator.color.contentMainPrimary)
                Spacer()
                IBResourcesAsset.calendarOutline.swiftUIImage
                    .resizable()
                    .scaledToFill()
                    .frame(12, 12)
                    .padding(.trailing, .spacing.space2xs)
                Text(transaction.rawData.createdDate)
                    .styleTypography(.bodyM)
                    .padding(.trailing, .spacing.spaceM)
                    .foregroundColor(themCoordinator.color.contentMainTertiary)
            }
        }
    }
    
    @MainActor
    private var transPoppupChecker: some View {
        VStack(spacing: .spacing.spaceS) {
            Button(action: {
                itemAction?(.approve(transaction.rawData))
            }, label: {
                HStack {
                    IBResourcesAsset.successOutline.swiftUIImage
                        .resizable()
                        .scaledToFill()
                        .frame(20, 20)
                        .padding(.trailing, .spacing.space2xs)
                    Text(IBResourcesStrings.duyet)
                        .styleTypography(.bodyM)
                        .foregroundColor(themCoordinator.color.contentMainSecondary)
                }
            })
            
            Button(action: {
                itemAction?(.delete(transaction.rawData))
            }, label: {
                HStack {
                    IBResourcesAsset.closeOutline.swiftUIImage
                        .resizable()
                        .scaledToFill()
                        .frame(20, 20)
                        .padding(.trailing, .spacing.space2xs)
                        .padding(.leading, .spacing.spaceS)
                    Text(IBResourcesStrings.tuChoi)
                        .styleTypography(.bodyM)
                        .foregroundColor(themCoordinator.color.contentMainSecondary)
                }
            })
        }.frame(width: 160, height: 88, alignment: .leading)
            .background(themCoordinator.color.bgMainTertiary)
            .cornerRadius(.radius.l)
            .shadow(color: Color.black.opacity(0.2), radius: .radius.m, x: .radius.none, y: .radius.s)
    }
}
