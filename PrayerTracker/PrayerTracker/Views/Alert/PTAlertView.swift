//
//  PTAlert.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 09/07/24.
//

import SwiftUI

struct PTAlertView<T: Hashable, M: View>: View {

    @Namespace private var namespace

    @Binding private var isPresented: Bool
    @State private var titleKey: LocalizedStringKey
    @State private var actionTextKey: LocalizedStringKey

    private var data: T?
    private var actionWithValue: ((T) -> ())?
    private var messageWithValue: ((T) -> M)?

    private var action: (() -> ())?
    private var message: (() -> M)?

    // Animation
    @State private var isAnimating = false
    private let animationDuration = 0.5
    private var ShowCancelButton: Bool
    
    init(
        _ titleKey: LocalizedStringKey,
        _ isPresented: Binding<Bool>,
        presenting data: T?,
        actionTextKey: LocalizedStringKey,
        cancelButton: Bool,
        action: @escaping (T) -> (),
        @ViewBuilder message: @escaping (T) -> M
    ) {
        _titleKey = State(wrappedValue: titleKey)
        _actionTextKey = State(wrappedValue: actionTextKey)
        _isPresented = isPresented

        self.data = data
        self.action = nil
        self.message = nil
        self.actionWithValue = action
        self.messageWithValue = message
        self.ShowCancelButton = cancelButton
    }

    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
                .opacity(isPresented ? 0.6 : 0)
                .zIndex(1)

            if isAnimating {
                VStack {
                    VStack {
                        /// Title
                        Text(titleKey)
                            .font(Font.PTButtonTitle)
                            .foregroundStyle(Color.PTAccentColor)
                            .padding(8)

                        /// Message
                        Group {
                            if let data, let messageWithValue {
                                messageWithValue(data)
                            } else if let message {
                                message()
                            }
                        }
                        .multilineTextAlignment(.center)

                        /// Buttons
                        HStack {
                            if ShowCancelButton {
                                CancelButton
                            }
                            DoneButton
                        }
                        .fixedSize(horizontal: false, vertical: true)
                        .padding()
                        .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.PTViewBackgroundColor)
                    .cornerRadius(35)
                }
                .padding()
                .transition(.slide)
                .zIndex(2)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            show()
        }
    }

    // MARK: Buttons
    var CancelButton: some View {
        Button {
            dismiss()
        } label: {
            Text(LocalizedStringKey("cancel"))
                .font(Font.PTAlertText)
                .foregroundStyle(Color.PTAccentColor)
                .padding()
                .lineLimit(1)
                .frame(maxWidth: .infinity)
                .background(Material.regular)
                .background(.gray)
                .clipShape(RoundedRectangle(cornerRadius: 30))
        }
    }

    var DoneButton: some View {
        Button {
            dismiss()

            if let data, let actionWithValue {
                actionWithValue(data)
            } else if let action {
                action()
            }
        } label: {
            Text(actionTextKey)
                .font(Font.PTAlertText)
                .foregroundStyle(Color.white)
                .padding()
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .background(Color.PTAccentColor)
                .clipShape(RoundedRectangle(cornerRadius: 30.0))
        }
    }

    func dismiss() {
        withAnimation(.easeInOut(duration: animationDuration)) {
            isAnimating = false
        } completion: {
            isPresented = false
        }
    }

    func show() {
        withAnimation(.easeInOut(duration: animationDuration)) {
            isAnimating = true
        }
    }
}


// MARK: - Overload
extension PTAlertView where T == Never {

    init(
        _ titleKey: LocalizedStringKey,
        _ isPresented: Binding<Bool>,
        actionTextKey: LocalizedStringKey,
        cancelButton: Bool,
        action: @escaping () -> (),
        @ViewBuilder message: @escaping () -> M
    ) where T == Never {
        _titleKey = State(wrappedValue: titleKey)
        _actionTextKey = State(wrappedValue: actionTextKey)
        _isPresented = isPresented

        self.data = nil
        self.action = action
        self.message = message
        self.actionWithValue = nil
        self.messageWithValue = nil
        self.ShowCancelButton = cancelButton
    }
}
