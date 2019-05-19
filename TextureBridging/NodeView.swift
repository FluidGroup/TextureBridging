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
  private let wrapperNode: WrapperNode
  
  // MARK: - Initializers
  
  public init(node: D, frame: CGRect = .zero) {
    
    self.node = node
    self.wrapperNode = WrapperNode(node: node)
    
    super.init(frame: frame)
    
    // To call `textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int)`
    super.numberOfLines = 0
    isUserInteractionEnabled = true
    
    addSubnode(wrapperNode)
    
    wrapperNode.calculatedLayoutDidChangeHandler = { [weak self] in
      Log.debug("calculatedLayoutDidChangeHandler")
      self?.invalidateIntrinsicContentSize()
    }
    
    wrapperNode.layoutDidFinishHandler = { [weak self] in
      Log.debug("layoutDidFinishHandler")
      self?.invalidateIntrinsicContentSize()
    }
  }
  
  @available(*, unavailable)
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
    
    let r = wrapperNode.layoutThatFits(range)
    return CGRect(origin: .zero, size: r.size)
  }
  
  // MARK: - Functions
  
  open override func layoutSubviews() {
    
    super.layoutSubviews()
    
    wrapperNode.frame = bounds
  }
}

private class WrapperNode : ASDisplayNode {
  
  var calculatedLayoutDidChangeHandler: () -> Void = {}
  var layoutDidFinishHandler: () -> Void = {}
  
  let node: ASDisplayNode
  
  init(node: ASDisplayNode) {
    
    self.node = node
    
    super.init()
    addSubnode(node)
  }
  
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    return ASWrapperLayoutSpec(layoutElement: node)
  }
  
  override func calculatedLayoutDidChange() {
    super.calculatedLayoutDidChange()
    calculatedLayoutDidChangeHandler()
  }
  
  override func layoutDidFinish() {
    super.layoutDidFinish()
    layoutDidFinishHandler()
  }
  
  override func layout() {
    super.layout()
  }
}

