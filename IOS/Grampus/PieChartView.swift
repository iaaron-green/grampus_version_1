//
//  PieChartView.swift
//  Pie Chart View
//
//

import UIKit

/// Defines a segment of the pie chart.
struct LabelledSegment {

  /// The color of the segment.
  var color: UIColor

  /// The name of the segment.
  var name: String

  /// The value of the segment.
  var value: CGFloat
}

extension Collection where Element : Numeric {
  func sum() -> Element {
    return reduce(0, +)
  }
}

extension NumberFormatter {
  static let toOneDecimalPlace: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 1
    return formatter
  }()
}

extension CGRect {
  init(centeredOn center: CGPoint, size: CGSize) {
    self.init(
      origin: CGPoint(
        x: center.x - size.width * 0.5, y: center.y - size.height * 0.5
      ),
      size: size
    )
  }

  var center: CGPoint {
    return CGPoint(
      //----
      x: origin.x + size.width * 0.3, y: origin.y + size.height * 0.3
      //----
    )
  }
}

extension CGPoint {
  func projected(by value: CGFloat, angle: CGFloat) -> CGPoint {
    return CGPoint(
      x: x + value * cos(angle), y: y + value * sin(angle)
    )
  }
}

extension UIColor {
  struct RGBAComponents {
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var alpha: CGFloat
  }

  var rgbaComponents: RGBAComponents {
    var components = RGBAComponents(red: 0, green: 0, blue: 0, alpha: 0)
    getRed(&components.red, green: &components.green, blue: &components.blue,
           alpha: &components.alpha)
    return components
  }

  var brightness: CGFloat {
    return rgbaComponents.brightness
  }
}

extension UIColor.RGBAComponents {
  var brightness: CGFloat {
    return (red + green + blue) / 3
  }
}

struct SegmentLabelFormatter {
  private let _getLabel: (LabelledSegment) -> String
  init(_ getLabel: @escaping (LabelledSegment) -> String) {
    self._getLabel = getLabel
  }
  func getLabel(for segment: LabelledSegment) -> String {
    return _getLabel(segment)
  }
}

extension SegmentLabelFormatter {
  /// Display the segment's name along with its value in parentheses.
  static let nameWithValue = SegmentLabelFormatter { segment in
    let formattedValue = NumberFormatter.toOneDecimalPlace
      .string(from: segment.value as NSNumber) ?? "\(segment.value)"
    return "\(segment.name) (\(formattedValue))"
  }

  /// Only display the segment's name.
  static let nameOnly = SegmentLabelFormatter { $0.name }
}

@IBDesignable
class PieChartView : UIView {

  /// An array of structs representing the segments of the pie chart.
  var segments = [LabelledSegment]() {
    // Re-draw view when the values get set.
    didSet { setNeedsDisplay() }
  }

  /// Defines whether the segment labels should be shown when drawing the pie
  /// chart.
  @IBInspectable
  var showSegmentLabels: Bool = true {
    didSet { setNeedsDisplay() }
  }

  /// The font to be used on the segment labels
  @IBInspectable
  var segmentLabelFont: UIFont = UIFont.systemFont(ofSize: 14) {
    didSet {
      textAttributes[.font] = segmentLabelFont
      setNeedsDisplay()
    }
  }

  /// A formatter describing how to map a segment to its displayed label.
  var segmentLabelFormatter = SegmentLabelFormatter.nameWithValue {
    didSet { setNeedsDisplay() }
  }

  // The ratio of how far away from the center of the pie chart the text
  // will appear.
  @IBInspectable
  var textPositionOffset: CGFloat = 0.67 {
    didSet { setNeedsDisplay() }
  }

  private let paragraphStyle: NSParagraphStyle = {
    var p = NSMutableParagraphStyle()
    p.alignment = .center
    return p.copy() as! NSParagraphStyle
  }()

  private lazy var textAttributes: [NSAttributedString.Key: Any] = [
    .paragraphStyle: self.paragraphStyle, .font: self.segmentLabelFont
  ]

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
      LabelledSegment(color: #colorLiteral(red: 1.0, green: 0.121568627, blue: 0.28627451, alpha: 1.0), name: "Red",        value: 10),
      LabelledSegment(color: #colorLiteral(red: 1.0, green: 0.541176471, blue: 0.0, alpha: 1.0), name: "Orange",     value: 30),
      LabelledSegment(color: #colorLiteral(red: 0.478431373, green: 0.423529412, blue: 1.0, alpha: 1.0), name: "Purple",     value: 27),
      LabelledSegment(color: #colorLiteral(red: 0.0, green: 0.870588235, blue: 1.0, alpha: 1.0), name: "Light Blue", value: 40),
      LabelledSegment(color: #colorLiteral(red: 0.392156863, green: 0.945098039, blue: 0.717647059, alpha: 1.0), name: "Green",      value: 25),
      LabelledSegment(color: #colorLiteral(red: 0.0, green: 0.392156863, blue: 1.0, alpha: 1.0), name: "Blue",       value: 38)
    ]
  }

  private func forEachSegment(
    _ body: (LabelledSegment, _ startAngle: CGFloat,
             _ endAngle: CGFloat) -> Void
  ) {
    // Enumerate the total value of the segments by using reduce to sum them.
    let valueCount = segments.lazy.map { $0.value }.sum()

    // The starting angle is -90 degrees (top of the circle, as the context is
    // flipped). By default, 0 is the right hand side of the circle, with the
    // positive angle being in an anti-clockwise direction (same as a unit
    // circle in maths).
    var startAngle: CGFloat = -.pi * 0.5

    // Loop through the values array.
    for segment in segments {
      // Get the end angle of this segment.
      let endAngle = startAngle + .pi * 2 * (segment.value / valueCount)
      defer {
        // Update starting angle of the next segment to the ending angle of this
        // segment.
        startAngle = endAngle
      }
      
      body(segment, startAngle, endAngle)
    }
  }

  override func draw(_ rect: CGRect) {

    // Get current context.
    guard let ctx = UIGraphicsGetCurrentContext() else { return }

    
    // Radius is the half the frame's width or height (whichever is smallest).
    //--
    let radius = min(frame.width, frame.height) * 0.3
    //--
    //--SIZE OF THE PIECHART
    
    // Center of the view.
    let viewCenter = bounds.center

    // Loop through the values array.
    forEachSegment { segment, startAngle, endAngle in

      // Set fill color to the segment color.
      ctx.setFillColor(segment.color.cgColor)

      // Move to the center of the pie chart.
      ctx.move(to: viewCenter)

      // Add arc from the center for each segment (anticlockwise is specified
      // for the arc, but as the view flips the context, it will produce a
      // clockwise arc)
      ctx.addArc(center: viewCenter, radius: radius, startAngle: startAngle,
                 endAngle: endAngle, clockwise: false)

      // Fill segment.
      ctx.fillPath()
    }
    if showSegmentLabels { // Do text rendering.
      forEachSegment { segment, startAngle, endAngle in
        // Get the angle midpoint.
        let halfAngle = startAngle + (endAngle - startAngle) * 0.5;

        // Get the 'center' of the segment.
        var segmentCenter = viewCenter
        if segments.count > 1 {
          segmentCenter = segmentCenter
            .projected(by: radius * textPositionOffset, angle: halfAngle)
        }

        // Text to render – the segment value is formatted to 1dp if needed to
        // be displayed.
        let textToRender = segmentLabelFormatter
          .getLabel(for: segment) as NSString

        // If too light, use black. If too dark, use white.
        textAttributes[.foregroundColor] =
          segment.color.brightness > 0.4 ? UIColor.black : UIColor.white

        let textRenderSize = textToRender.size(withAttributes: textAttributes)

        // The bounds that the text will occupy.
        let renderRect = CGRect(
          centeredOn: segmentCenter, size: textRenderSize
        )

        // Draw text in the rect, with the given attributes.
        textToRender.draw(in: renderRect, withAttributes: textAttributes)
      }
    }
  }
}
