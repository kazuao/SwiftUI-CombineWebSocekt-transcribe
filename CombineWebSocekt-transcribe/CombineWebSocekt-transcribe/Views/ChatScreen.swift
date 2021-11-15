//
//  ChatScreen.swift
//  CombineWebSocekt-transcribe
//
//  Created by kazunori.aoki on 2021/11/15.
//

import SwiftUI
import Combine

struct ChatScreen: View {
    @EnvironmentObject private var userInfo: UserInfo

    @StateObject private var model = ChatScreenModel()
    @State private var message = ""


    // MARK: Events
    private func onAppear() {
        model.connect(username: userInfo.username, userID: userInfo.userID)
    }

    private func onDisappear() {
        model.disconnect()
    }

    private func onCommit() {
        if !message.isEmpty {
            model.send(text: message)
            message = ""
        }
    }

    private func scrollToLastMessage(proxy: ScrollViewProxy) {
        if let lastMessage = model.message.last {
            withAnimation(.easeOut(duration: 0.4)) {
                proxy.scrollTo(lastMessage.id, anchor: .bottom)
            }
        }
    }

    // MARK: Body
    var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader { proxy in
                    LazyVStack(spacing: 8) {
                        ForEach(model.message) { message in
                            ChatMessageRow(message: message, isUser: message.userID == userInfo.userID)
                                .id(message.id)
                        }
                    }
                    .padding(10)
                    .onChange(of: model.message.count) { _ in
                        scrollToLastMessage(proxy: proxy)
                    }
                }
            }

            HStack {
                TextField("Message", text: $message, onEditingChanged: { _ in }, onCommit: onCommit)
                    .padding(10)
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(5)

                Button(action: onCommit) {
                    Image(systemName: "arrowshape.turn.up.right")
                        .font(.system(size: 20))
                        .padding(6)
                }
                .cornerRadius(5)
                .disabled(message.isEmpty)
                .hoverEffect(.highlight)
            }
            .padding()
        }
        .navigationTitle("Chat")
        .onAppear(perform: onAppear)
        .onDisappear(perform: onDisappear)
    }
}

private struct ChatMessageRow: View {
    static private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()

    let message: ReceivingChatMessage
    let isUser: Bool

    var body: some View {
        HStack {
            if isUser {
                Spacer()
            }

            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(message.user)
                        .fontWeight(.bold)
                        .font(.system(size: 12))

                    Text(Self.dateFormatter.string(from: message.date))
                        .font(.system(size: 10))
                        .opacity(0.7)
                }

                Text(message.message)
            }
            .foregroundColor(isUser ? .white : .black)
            .padding(10)
            .background(isUser ? .blue : Color(white: 0.95))
            .cornerRadius(5)

            if !isUser {
                Spacer()
            }
        }
        .transition(.scale(scale: 0, anchor: isUser ? .topTrailing : .topLeading))
    }
}
