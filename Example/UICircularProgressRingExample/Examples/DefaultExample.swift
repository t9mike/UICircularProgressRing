//
//  DefaultExample.swift
//  UICircularProgressRingExample
//
//  Created by Luis on 5/29/20.
//  Copyright © 2020 Luis. All rights reserved.
//

import Combine
import UICircularProgressRing
import SwiftUI

struct DefaultExample: View {
    @State private var progress: RingProgress = .percent(0)
    @State private var isRunning = false

    var body: some View {
        VStack {
            let lineWidth = 30
            ProgressRing(
                progress: $progress,
                outerRingStyle: .init(color: .color(.blue), strokeStyle: .init(lineWidth: CGFloat(lineWidth))),
                innerRingStyle: .init(color: .color(.red), strokeStyle: .init(lineWidth: CGFloat(lineWidth)))
            )
                .padding(32)

            Button(action: {
                withAnimation(.linear(duration: isRunning ? 1.0 : 5.0)) {
                    self.progress = isRunning ? .percent(0) : .percent(1)
                    self.isRunning.toggle()
                }
            }) {
                buttonLabel
            }
                .padding(16)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
                .offset(y: -32)
        }
        .navigationBarTitle("Basic")
    }

    private var buttonLabel: some View {
        if progress == .percent(1) {
            return Text("Restart Progress")
        } else {
            return Text("Start Progress")
        }
    }
}
