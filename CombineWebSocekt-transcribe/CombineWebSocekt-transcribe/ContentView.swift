//
//  ContentView.swift
//  CombineWebSocekt-transcribe
//
//  Created by kazunori.aoki on 2021/11/15.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var userInfo = UserInfo()

    var body: some View {
        NavigationView {
            SettingScreen()
        }
        .environmentObject(userInfo)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
