package struct CSSPseudoClass {
    public let name: String
    public let prefix: String

    public var className: String {
        "\(ElementaryCSSBaseClass)\(prefix)"
    }
}

package extension CSSPseudoClass {
    static let hover = CSSPseudoClass(name: "hover", prefix: "h")
    static let focus = CSSPseudoClass(name: "focus", prefix: "f")
    static let active = CSSPseudoClass(name: "active", prefix: "a")
    static let disabled = CSSPseudoClass(name: "disabled", prefix: "d")
}

package extension CSSPseudoClass {
    static let all: [CSSPseudoClass] = [hover, focus, active, disabled]
}
