import Foundation
import SwiftUI
import IBFoundation
import NavigationCoordinator
import SwiftMacro
import SwiftTheming
import ExyteGrid
import PureSwiftUI

@InjectionHotReload
struct MenuView: View {
    @Environment(\.navigationCoordinator) private var navigation
    @Environment(\.sheetCoordinator) private var sheet
    
    @State private var showDebit = false
    @State private var showCredit = false
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Button("Menu 1") {
                        navigation.execute(.navigate(IBInquiryRoute.mackerListTrasInquiy, animated: true))
                    }
                    .padding(.horizontal)
                    VStack {
                        Button("Menu 2") {
                            navigation.execute(.navigate(IBInquiryRoute.inquiryTransactionChecker, animated: true))
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.horizontal)
            }
            .greedyWidth()
            .navigationBarTitleDisplayMode(.inline)
            .navigationCoordinator(title: "Menu inquiry")
            .eraseToAnyView()
        }
    }
}
