import Elementary

// TODO: complete this and add most likey parameters here

@inlinable
public func Block<Tag: HTMLTagDefinition, Wrapped: HTML>(
    _ styles: ElementaryStyle...,
    tag: Tag.Type = HTMLTag.div.self,
    @HTMLBuilder content: () -> Wrapped
) -> HTMLElement<Tag, Wrapped> where Tag: HTMLTrait.Paired {
    Tag.makeStyledElement(styles) {
        content()
    }
}

@inlinable
public func Text<Tag: HTMLTagDefinition>(
    _ text: String,
    _ styles: ElementaryStyle...,
    tag: Tag.Type = HTMLTag.span.self
) -> HTMLElement<Tag, HTMLText> where Tag: HTMLTrait.Paired {
    HTMLElement(
        .class(styles.classNames()),
        .style(styles.styleValues())
    ) {
        text
    }
}

@inlinable
public func Paragraph<Tag: HTMLTagDefinition, Wrapped: HTML>(
    _ styles: ElementaryStyle...,
    tag: Tag.Type = HTMLTag.p.self,
    @HTMLBuilder content: () -> Wrapped
) -> HTMLElement<Tag, Wrapped> where Tag: HTMLTrait.Paired {
    Tag.makeStyledElement(styles) {
        content()
    }
}

extension HTMLElement {
    static func styled(
        _ styles: [ElementaryStyle],
        @HTMLBuilder content: () -> Content
    ) -> Self where Tag: HTMLTrait.Paired {
        .init(
            .class(styles.classNames()),
            .style(styles.styleValues()),
            content: content
        )
    }
}
