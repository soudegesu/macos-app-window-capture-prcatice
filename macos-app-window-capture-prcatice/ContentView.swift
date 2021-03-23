//
//  ContentView.swift
//  macos-app-window-capture-prcatice
//
//  Created by Takaaki Suzuki on 2021/03/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      Group {
        ForEach(WindowUtility.allActiveWindows(), id: \.windowId) { w in
          ScrollView(.horizontal) {
            HStack(spacing: 5) {
              Button(action: {
                
              }, label: {
                Image(decorative: w.preview, scale: 1.0)
                  .resizable()
                  .scaledToFit()
              }).buttonStyle(ScreenPreviewButtonStyle(
                maxWidth: 380,
                maxHeight: 240
              ))
            }
          }
        }
      }
    }
}

struct ScreenPreviewButtonStyle: ButtonStyle {
  private let maxWidth: CGFloat
  private let maxHeight: CGFloat

  init(maxWidth: CGFloat, maxHeight: CGFloat) {
    self.maxWidth = maxWidth
    self.maxHeight = maxHeight
  }

  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .frame(
        idealWidth: maxWidth,
        maxWidth: maxWidth,
        minHeight: maxHeight,
        idealHeight: maxHeight,
        maxHeight: maxHeight,
        alignment: .center
      )
      .onHover(perform: { hovering in
        if hovering {
          NSCursor.pointingHand.push()
        } else {
          NSCursor.pop()
        }
      })
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
