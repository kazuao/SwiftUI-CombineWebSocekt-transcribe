//
//  ChatMessage.swift
//  CombineWebSocekt-transcribe
//
//  Created by kazunori.aoki on 2021/11/15.
//

import Foundation

struct SubmittedChatMessage: Codable {
    let message: String
    let user: String
    let userID: UUID
}

struct ReceivingChatMessage: Codable, Identifiable {
    let date: Date
    let id: UUID
    let message: String
    let user: String
    let userID: UUID
}
