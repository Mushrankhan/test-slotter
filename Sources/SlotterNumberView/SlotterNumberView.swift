import Foundation
import SwiftUI

@available(iOS 13.0, *)
public struct SlotterContentView: View {
	@State private var number = 125
	public var body: some View {
		VStack {
			SlotterNumberView(number: $number, animationDuration: 1)
				.frame(height: 50) // Set the height to fit the size of the rolling numbers
				.padding()
			Button("Random") {
				withAnimation {
					number = Int.random(in: 123...99999)
				}
			}
			.padding()
		}
	}
}

@available(iOS 13.0, *)
public struct SlotterNumberView: View {
	@Binding var number: Int
	var animationDuration: Double = 0.3

	// Compute the individual digits
	var digits: [Int] {
		String(format: "%05d", number) // Ensure the number has at least 5 digits
			.compactMap { $0.wholeNumberValue }
	}

	public var body: some View {
		HStack {
			ForEach(0..<digits.count, id: \.self) { index in
				DigitView(digit: digits[index], animationDuration: animationDuration)
			}
		}
	}
}

@available(iOS 13.0, *)
struct DigitView: View {
	var digit: Int
	var animationDuration: Double

	var body: some View {
		GeometryReader { geometry in
			VStack(spacing: 0) {
				ForEach(0...9, id: \.self) { number in
					Text("\(number)")
						.font(.largeTitle)
						.fontWeight(.bold)
						.frame(width: geometry.size.width, height: geometry.size.height)
						.offset(y: -CGFloat(digit) * geometry.size.height)
				}
			}
			.frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
			.clipped()
		}
		.frame(width: 25, height: 40) // Set the frame for each digit
		.animation(.timingCurve(0.25, 0.1, 0.25, 1, duration: animationDuration), value: digit) // Set different animation speed-style
	}
}


