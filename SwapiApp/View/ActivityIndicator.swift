//
//  ActivityIndicator.swift
//  SwapiApp
//
//  Created by Atul Prakash on 17/09/2020.
//  Copyright © 2020 Atul Prakash. All rights reserved.
//

import SwiftUI

struct ActivityIndicator : UIViewRepresentable {
	
	typealias UIViewType = UIActivityIndicatorView
	let style : UIActivityIndicatorView.Style
	@Binding var animate: Bool
	
	func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> ActivityIndicator.UIViewType {
		return UIActivityIndicatorView(style: style)
	}
	
	func updateUIView(_ uiView: ActivityIndicator.UIViewType, context: UIViewRepresentableContext<ActivityIndicator>) {
		animate ? uiView.startAnimating() : uiView.stopAnimating()
	}
	
}


struct ActivityIndicatorView<Content> : View where Content : View {
	
	var content: () -> Content
	
	@State private var isAnimating: Bool = false
	
	var body: some View {
		GeometryReader { (geometry: GeometryProxy) in
			ForEach(0..<5) { index in
				Group {
					Circle()
						.frame(width: geometry.size.width / 5, height: geometry.size.height / 5)
						.scaleEffect(!self.isAnimating ? 1 - CGFloat(index) / 5 : 0.2 + CGFloat(index) / 5)
						.offset(y: geometry.size.width / 10 - geometry.size.height / 2)
				}.frame(width: geometry.size.width, height: geometry.size.height)
					.rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360))
					.animation(Animation
						.timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5)
						.repeatForever(autoreverses: false))
			}
		}
		.aspectRatio(1, contentMode: .fit)
		.onAppear {
			self.isAnimating = true
		}.onDisappear() {
			self.isAnimating = false
		}
	}
}
