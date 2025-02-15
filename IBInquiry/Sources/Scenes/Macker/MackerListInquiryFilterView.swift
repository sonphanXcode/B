//
//  MackerListInquiryFilterView.swift
//  IBInquiry
//
//  Created by Son phan on 9/2/25.
//  Copyright © 2025 bidv.com. All rights reserved.
//

import SwiftUI
import IBResources
import IBViewComponents
import IBFeatureCommon

struct MackerListInquiryFilterView: View {
    
    @Environment(\.navigationCoordinator) private var navigation
    @Environment(\.sheetCoordinator) public var sheetCoordinator
    @Environment(\.themeCoordinator) private var themCoordinator
    
    @StateObject private var viewModel = MackerListInquiryFilterViewModel()
    
    @State var expirationTime: String = ""
    @State var inquiryReseaon: String = ""
    @State var startDate: String = ""
    @State var endDate: String = ""
    @State var listTransactionsChannel: [CategoryResponseEntity] = []
    @State var listStatus: [String] = ["Mot", "Hai", "Ba"]
    @State var txnType: [String] = []
    var title: String
    @Binding var isShow: Bool
    
    var filter: MackerListTransInquiryFilter
    var handle: ((MackerListTransInquiryFilter) -> Void)?
    
    init(title: String, isShow: Binding<Bool>, filter: MackerListTransInquiryFilter, handle: ((MackerListTransInquiryFilter) -> Void)?) {
        self.title = title
        self._isShow = isShow
        self.filter = filter
        self.handle = handle
    }
    
    @MainActor
    func showDatePickerRangeSheet() {
        sheetCoordinator.show(
            IBCalendarBottomSheet.datePickerRange(
                title: IBResourcesStrings.chonKhoangThoiGian,
                fromDate: startDate,
                toDate: endDate,
                datePickerConfig: DatePickerConfig(startMonth: nil, endMonth: nil),
                onChange: { start, end in
                    startDate = start ?? ""
                    endDate = end ?? ""
                    expirationTime = "\(start ?? "") - \(end ?? "")"
                },
                navigation: navigation
            )
        )
    }
    
    var body: some View {
        IBBottomSheet(isPresented: $isShow,
                      detent: .height(UIScreen.main.bounds.height * 0.55),
                      title: title,
                      alignment: .leading,
                      wrapContentInsideScrollView: false,
                      onDismiss: {
            isShow = false
            handle?(filter.with(serviceType: "new type"))
        },
                      content: {
            VStack {
                ScrollView {
                    VStack(spacing: 12) {
                        
                        IBInputDropdownView(
                            label: IBResourcesStrings.thoiGianHieuLuc,
                            onTap: {
                                showDatePickerRangeSheet()
                            },
                            trailingIcon: Button(action: {
                                showDatePickerRangeSheet()
                            }, label: {
                                IBResourcesAsset.calendarOutline.swiftUIImage.resizable().frame(width: 16, height: 16).erased()
                            }).erased(),
                            text: expirationTime)
                        
                        IBInputDropdownListView(
                            listContent: .constant(
                                listTransactionsChannel.compactMap {
                                    .init(
                                        isSelected: true, title: $0.name ?? "",
                                        data: $0)
                                }), hintText: IBResourcesStrings.trangThai,
                            title: IBResourcesStrings.trangThai,
                            onTap: {
                                sheetCoordinator.show(
                                    TransSheet.paymentSelectTransType(
                                        selectResult: {
                                            listTransactionsChannel = $0
                                        }, selectedItem: listTransactionsChannel))
                            }, onDeleteContent: { index in
                                listTransactionsChannel.remove(at: index)
                            }, onClearAll: {
                                listTransactionsChannel = []
                            })
                        IBInputDropdownListView(
                            listContent: .constant(
                                listTransactionsChannel.compactMap {
                                    .init(
                                        isSelected: true, title: $0.name ?? "",
                                        data: $0)
                                }), hintText: IBResourcesStrings.loaiGiaoDich,
                            title: IBResourcesStrings.loaiGiaoDich,
                            onTap: {
                                sheetCoordinator.show(
                                    TransSheet.paymentSelectTransType(
                                        selectResult: {
                                            listTransactionsChannel = $0
                                        }, selectedItem: listTransactionsChannel))
                            }, onDeleteContent: { index in
                                listTransactionsChannel.remove(at: index)
                            }, onClearAll: {
                                listTransactionsChannel = []
                            })
                        IBInputDropdownView(
                            label: IBResourcesStrings.lyDo,
                            onTap: {
                                sheetCoordinator.show(
                                    TransSheet.inquirySelectReason(selectResult: {
                                        inquiryReseaon = $0.name ?? ""
                                    }, selectedItem: inquiryReseaon.isEmpty ? nil : CategoryResponseEntity(name: inquiryReseaon)))
                            },
                            trailingIcon: Button(action: {}, label: {
                                IBResourcesAsset.arrowBottomOutline.swiftUIImage.resizable().frame(width: 16, height: 16).erased()
                            }),
                            text: inquiryReseaon)
                    }
                }.padding(.bottom, 10)
                
                HStack {
                    IBButton(
                        action: {
                            expirationTime = ""
                            inquiryReseaon = ""
                            startDate = ""
                            endDate = ""
                            txnType = []
                
                            handle?(filter.with(model: MackerListInquiryFilterModel(), filterCount: 0))
                        },
                        title: IBResourcesStrings.xoaBoLoc,
                        style: .secondaryGray,
                        size: .large
                    ).padding(.trailing, 16)
                    IBButton(
                        action: {
                            let filterObject = viewModel.createTransFilterModel(createdDateFrom: startDate, createdDateTo: endDate, txnType: txnType, inquiryReason: InquiryReasonType(rawValue: inquiryReseaon)?.code ?? "", status: [], keyword: "")
                            
                            isShow = false
                            handle?(filter.with(model: filterObject.0, filterCount: filterObject.1))
                        },
                        title: IBResourcesStrings.apDung,
                        style: .primary,
                        size: .large
                    )
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(themCoordinator.color.bgMainTertiary)
        })
    }
}

enum InquiryReasonType: String {
    case lamRoThongTin = "Làm rõ thông tin"
    case deNghiHoanTra = "Đề nghị hoàn trả"
    case chinhSuaNoiDung = "Chỉnh sửa nội dung"
    case chinhSuaTaiKhoanHuong = "Chỉnh sửa tài khoản hưởng"
    case chinhSuaTenNguoiHuong = "Chỉnh sửa tên người hưởng"
    
    var code: String {
        switch self {
        case .lamRoThongTin:
            return "INFORMATION_VERIFICATION"
        case .deNghiHoanTra:
            return "REFUND_REQUEST"
        case .chinhSuaNoiDung:
            return "UPDATE_REMARK"
        case .chinhSuaTaiKhoanHuong:
            return "UPDATE_BEN_ACCNO"
        case .chinhSuaTenNguoiHuong:
            return "UPDATE_BEN_NAME"
        }
    }
}
