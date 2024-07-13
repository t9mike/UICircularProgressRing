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

    private let onDidTapSubject = PassthroughSubject<Void, Never>()
    private var onDidTapPublisher: AnyPublisher<Void, Never> {
        onDidTapSubject.eraseToAnyPublisher()
    }

    private var progressPublisher: AnyPublisher<RingProgress, Never> {
        onDidTapPublisher
            .map { self.progress == .percent(1) ? RingProgress.percent(0) : RingProgress.percent(1) }
            .prepend(progress)
            .eraseToAnyPublisher()
    }

    var body: some View {
        VStack {
            let lineWidth = 30
            ProgressRing(
                progress: $progress,
                outerRingStyle: .init(color: .color(.blue), strokeStyle: .init(lineWidth: CGFloat(lineWidth))),
                innerRingStyle: .init(color: .color(.red), strokeStyle: .init(lineWidth: CGFloat(lineWidth)))
            )
            .animation(.easeInOut(duration: self.progress.asDouble == 0 ? 0.5 : 5))
                .padding(32)

            Button(action: {
                if self.progress.asDouble == 0 {
                    self.progress = .percent(1)
                } else {
                    self.progress = .percent(0)
                }
//                self.onDidTapSubject.send(())
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
        .onReceive(progressPublisher) { progress in
            self.progress = progress
        }
    }

    private var buttonLabel: some View {
        if progress == .percent(1) {
            return Text("Restart Progress")
        } else {
            return Text("Start Progress")
        }
    }
}
