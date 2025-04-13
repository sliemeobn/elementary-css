import CSSDefinitions

public struct ElementaryStyle: Sendable {
    internal var property: CSSProperty
    internal var value: String

    init(property: CSSProperty, value: String) {
        self.property = property
        self.value = value
    }

    init(property: CSSProperty, value: some RawRepresentable<String>) {
        self.property = property
        self.value = value.rawValue
    }
}

extension ElementaryStyle {
    public struct Condition: Sendable {
        enum Value {
            case pseudoClass(CSSPseudoClass)
        }
        var value: Value

        init(_ value: Value) {
            self.value = value
        }

        var className: String {
            switch value {
            case .pseudoClass(let pseudoClass):
                pseudoClass.className
            }
        }

        var prefix: String {
            switch value {
            case .pseudoClass(let pseudoClass):
                pseudoClass.prefix
            }
        }
    }
}

public extension ElementaryStyle.Condition {
    static var hover: Self { Self(.pseudoClass(.hover)) }
    static var active: Self { Self(.pseudoClass(.active)) }
    static var focus: Self { Self(.pseudoClass(.focus)) }
    static var disabled: Self { Self(.pseudoClass(.disabled)) }
}

extension ElementaryStyle {
    // Box Model
    public static func margin(_ value: CSSLength) -> Self {
        Self(property: .margin, value: value)
    }
    public static func margin(t: CSSLength = 0, r: CSSLength = 0, b: CSSLength = 0, l: CSSLength = 0) -> Self {
        Self(property: .margin, value: "\(t.rawValue) \(r.rawValue) \(b.rawValue) \(l.rawValue)")
    }
    public static func margin(y: CSSLength = 0, x: CSSLength = 0) -> Self {
        Self(property: .margin, value: "\(y.rawValue) \(x.rawValue)")
    }
    public static func padding(_ value: CSSLength) -> Self {
        Self(property: .padding, value: value)
    }
    public static func padding(t: CSSLength = 0, r: CSSLength = 0, b: CSSLength = 0, l: CSSLength = 0) -> Self {
        Self(property: .padding, value: "\(t.rawValue) \(r.rawValue) \(b.rawValue) \(l.rawValue)")
    }
    public static func padding(y: CSSLength = 0, x: CSSLength = 0) -> Self {
        Self(property: .padding, value: "\(y.rawValue) \(x.rawValue)")
    }
    public static func background(_ value: CSSColor) -> Self {
        Self(property: .background, value: value)
    }

    // Border
    public static func borderColor(_ value: CSSColor) -> Self {
        Self(property: .borderColor, value: value)
    }
    public static func borderRadius(_ value: CSSLength) -> Self {
        Self(property: .borderRadius, value: value)
    }
    public static func borderStyle(_ value: String) -> Self {
        Self(property: .borderStyle, value: value)
    }
    public static func borderWidth(_ value: CSSLength) -> Self {
        Self(property: .borderWidth, value: value)
    }
    public static func borderWidth(t: CSSLength = 0, r: CSSLength = 0, b: CSSLength = 0, l: CSSLength = 0) -> Self {
        Self(property: .borderWidth, value: "\(t.rawValue) \(r.rawValue) \(b.rawValue) \(l.rawValue)")
    }
    public static func borderWidth(y: CSSLength = 0, x: CSSLength = 0) -> Self {
        Self(property: .borderWidth, value: "\(y.rawValue) \(x.rawValue)")
    }

    // Sizing
    public static func height(_ value: CSSLength) -> Self {
        Self(property: .height, value: value)
    }
    public static func width(_ value: CSSLength) -> Self {
        Self(property: .width, value: value)
    }
    public static func minHeight(_ value: CSSLength) -> Self {
        Self(property: .minHeight, value: value)
    }
    public static func minWidth(_ value: CSSLength) -> Self {
        Self(property: .minWidth, value: value)
    }
    public static func maxHeight(_ value: CSSLength) -> Self {
        Self(property: .maxHeight, value: value)
    }
    public static func maxWidth(_ value: CSSLength) -> Self {
        Self(property: .maxWidth, value: value)
    }

    // Layout
    public static func display(_ value: CSSDisplay) -> Self {
        Self(property: .display, value: value)
    }
    public static func flexFlow(_ value: CSSFlexFlow) -> Self {
        Self(property: .flexFlow, value: value)
    }
    public static func justifyContent(_ value: CSSJustifyContent) -> Self {
        Self(property: .justifyContent, value: value)
    }
    public static func alignItems(_ value: CSSAlignItems) -> Self {
        Self(property: .alignItems, value: value)
    }
    public static func alignContent(_ value: CSSAlignContent) -> Self {
        Self(property: .alignContent, value: value)
    }
    public static func gap(_ value: CSSLength) -> Self {
        Self(property: .gap, value: value)
    }
    public static func flex(_ value: CSSFlex) -> Self {
        Self(property: .flex, value: value)
    }
    public static func overflow(_ value: CSSOverflow) -> Self {
        Self(property: .overflow, value: value)
    }

    // Positioning
    public static func position(_ value: CSSPosition) -> Self {
        Self(property: .position, value: value)
    }
    public static func inset(_ value: CSSLength) -> Self {
        Self(property: .inset, value: value)
    }

    public static func inset(t: CSSLength = .auto, r: CSSLength = .auto, b: CSSLength = .auto, l: CSSLength = .auto) -> Self {
        Self(property: .inset, value: "\(t.rawValue) \(r.rawValue) \(b.rawValue) \(l.rawValue)")
    }

    public static func inset(y: CSSLength = .auto, x: CSSLength = .auto) -> Self {
        Self(property: .inset, value: "\(y.rawValue) \(x.rawValue)")
    }

    // Typography
    public static func color(_ value: CSSColor) -> Self {
        Self(property: .color, value: value)
    }
    public static func textAlign(_ value: CSSTextAlign) -> Self {
        Self(property: .textAlign, value: value)
    }
    public static func fontWeight(_ value: CSSFontWeight) -> Self {
        Self(property: .fontWeight, value: value)
    }
    public static func fontSize(_ value: CSSLength) -> Self {
        Self(property: .fontSize, value: value)
    }
    public static func fontSize(_ value: CSSFontSize) -> Self {
        Self(property: .fontSize, value: value)
    }
    public static func fontFamily(_ value: CSSFontFamily) -> Self {
        Self(property: .fontFamily, value: value)
    }
    public static func lineHeight(_ value: CSSLength) -> Self {
        Self(property: .lineHeight, value: value)
    }
    public static func letterSpacing(_ value: CSSLength) -> Self {
        Self(property: .letterSpacing, value: value)
    }
    public static func textTransform(_ value: String) -> Self {
        Self(property: .textTransform, value: value)
    }
    public static func textDecoration(_ value: String) -> Self {
        Self(property: .textDecoration, value: value)
    }
    public static func whiteSpace(_ value: String) -> Self {
        Self(property: .whiteSpace, value: value)
    }
    public static func textOverflow(_ value: String) -> Self {
        Self(property: .textOverflow, value: value)
    }
    public static func textShadow(_ value: String) -> Self {
        Self(property: .textShadow, value: value)
    }

    // Effects
    public static func opacity(_ value: Double) -> Self {
        Self(property: .opacity, value: "\(value)")
    }
    public static func transform(_ value: CSSTransform) -> Self {
        Self(property: .transform, value: value)
    }
    public static func transformOrigin(_ value: CSSTransformOrigin) -> Self {
        Self(property: .transformOrigin, value: value)
    }
    public static func transition(_ value: String) -> Self {
        Self(property: .transition, value: value)
    }
}
