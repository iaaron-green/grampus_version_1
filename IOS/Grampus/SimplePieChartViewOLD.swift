//
//  SimplePieChartView.swift
//  Pie Chart View
//
//

// Simplified version of PieChartView.

import UIKit

struct Segment {

  /// The color of a given segment.
  var color: UIColor

  // The value of a given segment – will be used to automatically calculate a
  /// ratio.
  var value: CGFloat
}

class SimplePieChartView : UIView {

  /// An array of structs representing the segments of the pie chart.
  var segments = [Segment]() {
    didSet {
      setNeedsDisplay() // re-draw view when the values get set
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initialize()
  }

  private func initialize() {
    // When overriding drawRect, you must specify this to maintain transparency.
    isOpaque = false
  }

  override func prepareForInterfaceBuilder() {
    // Show sample data.
    segments = [
      Segment(color: .red,    value: 57),
      Segment(color: .blue,   value: 30),
      Segment(color: .green,  value: 25),
      Segment(color: .yellow, value: 40)
    ]
  }

  override func draw(_ rect: CGRect) {

    // Get current context.
    guard let ctx = UIGraphicsGetCurrentContext() else { return }

    // Radius is the half the frame's width or height (whichever is smallest).
    let radius = min(frame.size.width, frame.size.height) * 0.5

    // Center of the view.
    let viewCenter = CGPoint(x: bounds.size.width * 5.5, y: bounds.size.height * 5.5)

    // Enumerate the total value of the segments by using reduce to sum them.
    let valueCount = segments.reduce(0, {$0 + $1.value})

    // The starting angle is -90 degrees (top of the circle, as the context is
    // flipped). By default, 0 is the right hand side of the circle, with the
    // positive angle being in an anti-clockwise direction (same as a unit
    // circle in maths).
    var startAngle = -CGFloat.pi * 0.5

    for segment in segments { // Loop through the values array.

      // Set fill color to the segment color.
      ctx.setFillColor(segment.color.cgColor)

      // Update the end angle of the segment.
      let endAngle = startAngle + 2 * .pi * (segment.value / valueCount)

      // Move to the center of the pie chart.
      ctx.move(to: viewCenter)

      // Add arc from the center for each segment (anticlockwise is specified
      // for the arc, but as the view flips the context, it will produce a
      // clockwise arc).
      ctx.addArc(center: viewCenter, radius: radius,
                 startAngle: startAngle, endAngle: endAngle, clockwise: false)

      // Fill segment.
      ctx.fillPath()

      // Update starting angle of the next segment to the ending angle of this
      // segment.
      startAngle = endAngle
    }
  }
}

