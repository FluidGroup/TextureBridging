//
// NodeView
//
// Copyright (c) 2019 Hiroshi Kimura
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import AsyncDisplayKit

///
open class NodeView<D: ASDisplayNode>: UILabel /* To use `textRect` method */ {

  // MARK: - Unavailable

  @available(*, unavailable)
  override open var text: String? {
    didSet {}
  }

  @available(*, unavailable)
  override open var font: UIFont! {
    didSet {}
  }

  @available(*, unavailable)
  override open var textColor: UIColor! {
    didSet {}
  }

  @available(*, unavailable)
  override open var shadowColor: UIColor? {
    didSet {}
  }

  @available(*, unavailable)
  override open var shadowOffset: CGSize {
    didSet {}
  }

  @available(*, unavailable)
  override open var textAlignment: NSTextAlignment {
    didSet {}
  }

  @available(*, unavailable)
  override open var lineBreakMode: NSLineBreakMode {
    didSet {}
  }

  @available(*, unavailable)
  open override var attributedText: NSAttributedString? {
    didSet {}
  }

  @available(*, unavailable)
  open override var highlightedTextColor: UIColor? {
    didSet {}
  }

  @available(*, unavailable)
  open override var isHighlighted: Bool {
    didSet {}
  }

  @available(*, unavailable)
  open override var isEnabled: Bool {
    didSet {}
  }

  @available(*, unavailable)
  open override var numberOfLines: Int {
    didSet {}
  }

  @available(*, unavailable)
  open override var adjustsFontSizeToFitWidth: Bool {
    didSet {}
  }

  @available(*, unavailable)
  open override var baselineAdjustment: UIBaselineAdjustment {
    didSet {}
  }

  @available(*, unavailable)
  open override var minimumScaleFactor: CGFloat {
    didSet {}
  }

  @available(*, unavailable)
  open override var allowsDefaultTighteningForTruncation: Bool {
    didSet {}
  }

  @available(*, unavailable)
  open override func drawText(in rect: CGRect) {
    super.drawText(in: rect)
  }

  @available(*, unavailable)
  open override var preferredMaxLayoutWidth: CGFloat {
    didSet {}
  }

  // MARK: - Properties

  public let node: D
  private let wrapper: WrapperNode
  private let delegateProxy = __InterfaceStateDelegateProxy()

  // MARK: - Initializers

  public init(node: D, frame: CGRect = .zero) {

    self.node = node
    self.wrapper = .init(wrapped: node)

    super.init(frame: frame)

    // To call `textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int)`
    super.numberOfLines = 0
    isUserInteractionEnabled = true

    addSubnode(wrapper)
    wrapper.add(delegateProxy)

    delegateProxy.didLayoutBlock = { [weak self] in
      self?.invalidateIntrinsicContentSize()
    }

  }

  @available(*, unavailable)
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    node.remove(delegateProxy)
  }

  open override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {

    let validate: (_ value: CGFloat, _ fallback: CGFloat) -> CGFloat = { value, fallback in
      // To guard crash inside Texture
      guard ASPointsValidForSize(value) else {
        return fallback
      }
      return value
    }

    var range = ASSizeRangeUnconstrained

    range.max.width = validate(bounds.width, 10000)

    let r = wrapper.calculateLayoutThatFits(range)
    Log.debug(bounds, r)
    return CGRect(origin: .zero, size: r.size)
  }

  // MARK: - Functions

  open override func layoutSubviews() {

    super.layoutSubviews()

    wrapper.frame = bounds
  }
}

private final class WrapperNode: ASDisplayNode {

  private let wrapped: ASDisplayNode

  init(wrapped: ASDisplayNode) {
    self.wrapped = wrapped
    super.init()
    addSubnode(wrapped)
  }

  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    ASWrapperLayoutSpec(layoutElement: wrapped)
  }
}

private final class __InterfaceStateDelegateProxy: NSObject, ASInterfaceStateDelegate {

  var didLayoutBlock: (() -> Void)?

  @objc dynamic func interfaceStateDidChange(_ newState: ASInterfaceState, from oldState: ASInterfaceState) {

  }

  @objc dynamic func didEnterVisibleState() {

  }

  @objc dynamic func didExitVisibleState() {

  }

  func didEnterDisplayState() {

  }

  @objc dynamic func didExitDisplayState() {

  }

  @objc dynamic func didEnterPreloadState() {

  }

  @objc dynamic func didExitPreloadState() {

  }

  @objc dynamic func nodeDidLayout() {
    didLayoutBlock?()
  }

  @objc dynamic func nodeDidLoad() {

  }

  @objc dynamic func hierarchyDisplayDidFinish() {

  }

}

