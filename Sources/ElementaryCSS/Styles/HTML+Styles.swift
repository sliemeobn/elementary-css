import CSSDefinitions
import Elementary

struct StyleSet: Sendable {
    var styles: [ElementaryStyle]
    var condition: ElementaryStyle.Condition?

    func style<Wrapped: HTML>(_ content: Wrapped) -> _AttributedElement<Wrapped> where Wrapped.Tag: HTMLTrait.Attributes.Global {
        content.attributes(
            .class(styles.classNames(condition: condition)),
            .style(styles.styleValues(condition: condition))
        )
    }
}

extension HTML where Tag: HTMLTrait.Attributes.Global {
    public func style(_ styles: ElementaryStyle...) -> _AttributedElement<Self> {
        StyleSet(styles: styles).style(self)
    }

    public func style(when condition: ElementaryStyle.Condition, _ styles: ElementaryStyle...) -> _AttributedElement<Self> {
        StyleSet(styles: styles, condition: condition).style(self)
    }

    public func style(contentsOf styles: [ElementaryStyle]) -> _AttributedElement<Self> {
        StyleSet(styles: styles).style(self)
    }

    public func style(when condition: ElementaryStyle.Condition, contentsOf styles: [ElementaryStyle]) -> _AttributedElement<Self> {
        StyleSet(styles: styles, condition: condition).style(self)
    }
}

extension HTMLTagDefinition {
    @inlinable @inline(__always)
    internal static func makeStyledElement<Wrapped: HTML>(
        _ styles: [ElementaryStyle],
        @HTMLBuilder content: () -> Wrapped
    ) -> HTMLElement<Self, Wrapped>
    where Self: HTMLTrait.Paired {
        .init(
            .class(styles.classNames()),
            .style(styles.styleValues()),
            content: content
        )
    }
}

extension [ElementaryStyle] {
    @usableFromInline
    borrowing func styleValues(condition: ElementaryStyle.Condition? = nil) -> [(key: String, value: String)] {
        if let prefix = condition?.prefix {
            self.map { style in (key: style.property.prefixedVariable(prefix: prefix), value: style.value) }
        } else {
            self.map { style in (key: style.property.prefixedVariable, value: style.value) }
        }
    }

    @usableFromInline
    borrowing func classNames(condition: ElementaryStyle.Condition? = nil) -> [String] {
        if let prefix = condition?.prefix {
            [ElementaryCSSBaseClass] + self.map { style in style.property.className(prefix: prefix) }
        } else {
            [ElementaryCSSBaseClass]
        }
    }
}
