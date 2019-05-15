
import UIKit
import AsyncDisplayKit

open class NodeView<D: ASDisplayNode>: UILabel /* To use `textRect` method */ {
  
  // MARK: - Properties
  
  public let embedNode: D
  private let wrapperNode: WrapperNode
  
  // MARK: - Initializers
  
  public init(embedNode: D, frame: CGRect = .zero) {
    
    self.embedNode = embedNode
    self.wrapperNode = WrapperNode(embedNode: embedNode)
    
    super.init(frame: frame)
    
    // To call `textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int)`
    numberOfLines = 0
    isUserInteractionEnabled = true
    
    addSubnode(wrapperNode)
    
    wrapperNode.calculatedLayoutDidChangeHandler = { [weak self] in
      self?.invalidateIntrinsicContentSize()
    }
    
    wrapperNode.layoutDidFinishHandler = { [weak self] in
      self?.invalidateIntrinsicContentSize()
    }
  }
  
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
  
  let embedNode: ASDisplayNode
  
  init(embedNode: ASDisplayNode) {
    
    self.embedNode = embedNode
    
    super.init()
    addSubnode(embedNode)
  }
  
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    return ASWrapperLayoutSpec(layoutElement: embedNode)
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

