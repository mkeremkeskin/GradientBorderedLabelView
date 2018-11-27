//
//  GradientBorderedLabelView.swift
//  GradientBorderedLabelView
//
//  Created by mkeremkeskin on 27.11.2018.
//

import Foundation
import UIKit

@IBDesignable
public class GradientBorderedLabelView: UIView {

    @IBInspectable public var fontSizeOfLabel: CGFloat = CGFloat(12) {
        didSet {
            fontSize = fontSizeOfLabel
            configure()
        }
    }

    @IBInspectable public var textOfLabel: String = "Some gradient text" {
        didSet {
            text = textOfLabel
            configure()
        }
    }

    @IBInspectable public var widthOfBorder: CGFloat = CGFloat(3) {
        didSet {
            widthOfViewBorder = widthOfBorder
            configure()
        }
    }

    @IBInspectable public var radiusOfCorner: CGFloat = CGFloat(6) {
        didSet {
            radiusOfViewBorder = radiusOfCorner
            configure()
        }
    }

    @IBInspectable public var firstColor: UIColor = UIColor(red: 37/255.0, green: 214/255.0, blue: 162/255.0, alpha: 1) {
        didSet {
            startColor = firstColor
            configure()
        }
    }

    @IBInspectable public var secondColor: UIColor = UIColor(red: 37/255.0, green: 166/255.0, blue: 214/255.0, alpha: 1) {
        didSet {
            endColor = secondColor
            configure()
        }
    }

    @IBInspectable public var useBoldFont: Bool = false {
        didSet {
            isBoldFont = useBoldFont
            configure()
        }
    }

    @IBInspectable public var labelBackgroundColor: UIColor = UIColor.white {
        didSet {
            backgroundColorOfLabel = labelBackgroundColor
            configure()
        }
    }

    /** Available only when creating programmatically */
    public var customFontName: String?

    private var fontSize: CGFloat = CGFloat(12)
    private var text: String? = "Some gradient text"
    private var widthOfViewBorder: CGFloat = CGFloat(1.5)
    private var radiusOfViewBorder: CGFloat = CGFloat(3)
    private var startColor: UIColor? = UIColor(red: 37/255.0, green: 214/255.0, blue: 162/255.0, alpha: 1)
    private var endColor: UIColor? = UIColor(red: 37/255.0, green: 166/255.0, blue: 214/255.0, alpha: 1)
    private var isBoldFont: Bool? = false
    private var backgroundColorOfLabel: UIColor? = UIColor.white

    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configure()
    }

    func configure(){

        for subview in subviews {
            subview.removeFromSuperview()
        }

        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width , height: self.frame.height))
        bgView.backgroundColor = backgroundColorOfLabel
        bgView.layer.cornerRadius = radiusOfViewBorder

        let widthOfString = self.frame.width - (2 * widthOfViewBorder)
        var heightOfString = text!.height(withConstrainedWidth: widthOfString, font: getCurrentFont())

        while heightOfString > self.frame.height {
            fontSize = fontSize - 1.0
            heightOfString = text!.height(withConstrainedWidth: widthOfString, font: getCurrentFont())
        }

        let textLayer = CenteredTextLayer()
        textLayer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        textLayer.string = text
        textLayer.isWrapped = true
        textLayer.truncationMode = kCAAlignmentCenter
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.borderWidth = widthOfViewBorder
        textLayer.cornerRadius = radiusOfViewBorder
        let fontName: CFString = getCurrentFont().fontName as CFString
        textLayer.font = CTFontCreateWithName(fontName, fontSize, nil)
        textLayer.fontSize = fontSize

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bgView.frame
        gradientLayer.colors = [
            endColor!.cgColor,
            startColor!.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        gradientLayer.mask = textLayer

        bgView.layer.addSublayer(gradientLayer)

        self.addSubview(bgView)
        self.setNeedsDisplay()
    }

    private func getCurrentFont() -> UIFont {
        if customFontName != nil {
            return UIFont(name: customFontName!, size: fontSize)!
        }
        else {
            return (isBoldFont! ? UIFont.systemFont(ofSize: fontSize, weight: .bold) : UIFont.systemFont(ofSize: fontSize, weight: .regular))
        }
    }
}

/** CATextLayer centered both vertically and horizontally */
public class CenteredTextLayer: CATextLayer {

    public override init() {
        super.init()
        self.alignmentMode = kCAAlignmentCenter
    }

    public override init(layer: Any) {
        super.init(layer: layer)
    }

    public required init(coder aDecoder: NSCoder) {
        super.init(layer: aDecoder)
    }

    public override func draw(in ctx: CGContext) {
        let textHeight = (string as! String).height(withConstrainedWidth: self.bounds.size.width, font: self.font as! UIFont)
        let yDiff = (self.bounds.size.height - textHeight)/2

        ctx.saveGState()
        ctx.translateBy(x: 0.0, y: yDiff)
        super.draw(in: ctx)
        ctx.restoreGState()
    }

}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}

