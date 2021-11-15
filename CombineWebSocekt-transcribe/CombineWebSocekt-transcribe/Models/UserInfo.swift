//
//  UserInfo.swift
//  CombineWebSocekt-transcribe
//
//  Created by kazunori.aoki on 2021/11/15.
//

import Foundation
import Combine

class UserInfo: ObservableObject {
    let userID = UUID()
    @Published var username = ""
}
