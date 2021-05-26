//
//  DemoStackScrollViewController.swift
//  TextureBridgingDemo
//
//  Created by muukii on 2020/06/09.
//  Copyright © 2020 muukii. All rights reserved.
//

import Foundation
import EasyPeasy
import StackScrollView
import TextureSwiftSupport
import TextureBridging

final class DemoStackScrollViewController: UIViewController {

  private let stackScrollView = StackScrollView()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(stackScrollView)
    stackScrollView.easy.layout(Edges())

    stackScrollView.append(view: PaddingView.init(padding: .zero, bodyView: NodeView(node: Component())))
    stackScrollView.append(view: PaddingView.init(padding: .zero, bodyView: NodeView(node: FlexWrapComponent())))
  }
}

public final class PaddingView<Body: UIView>: UIView {
  // MARK: Public
  public let body: Body
  public convenience init(padding: UIEdgeInsets, bodyView: Body) {
    self.init(
      padding: (
        top: Constant(value: padding.top, relation: .equal, multiplier: 1),
        left: Constant(value: padding.left, relation: .equal, multiplier: 1),
        bottom: Constant(value: padding.bottom, relation: .equal, multiplier: 1),
        right: Constant(value: padding.right, relation: .equal, multiplier: 1)
      ), bodyView: bodyView
    )
  }
  public init(padding: (top: Constant, left: Constant, bottom: Constant, right: Constant), bodyView: Body) {
    self.body = bodyView
    super.init(frame: .zero)
    self.addSubview(bodyView)
    bodyView.easy.layout(
      Center().with(.low)
    )
    let paddingTop = padding.top
    bodyView.easy.layout(
      Top(paddingTop).with(paddingTop.relation == .equal ? .required : .high)
    )
    let paddingLeft = padding.left
    bodyView.easy.layout(
      Left(paddingLeft).with(paddingLeft.relation == .equal ? .required : .high)
    )
    let paddingBottom = padding.bottom
    bodyView.easy.layout(
      Bottom(paddingBottom).with(paddingBottom.relation == .equal ? .required : .high)
    )
    let paddingRight = padding.right
    bodyView.easy.layout(
      Right(paddingRight).with(paddingRight.relation == .equal ? .required : .high)
    )
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

public class PaddingView2<Body: UIView>: UIView {

  public let body: Body

  ///
  ///
  /// - Parameters:
  ///   - padding: if you no needs padding, use .infinity.
  ///   - bodyView: Embedded view
  public init(padding: UIEdgeInsets, bodyView: Body) {

    self.body = bodyView

    super.init(frame: .zero)

    bodyView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(bodyView)

    if padding.top.isFinite {
      bodyView.topAnchor.constraint(equalTo: topAnchor, constant: padding.top).isActive = true
    } else {
      bodyView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor).isActive = true
    }

    if padding.right.isFinite {
      bodyView.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding.right).isActive = true
    } else {
      bodyView.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor).isActive = true
    }

    if padding.left.isFinite {
      bodyView.leftAnchor.constraint(equalTo: leftAnchor, constant: padding.left).isActive = true
    } else {
      bodyView.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor).isActive = true
    }

    if padding.bottom.isFinite {
      bodyView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding.bottom).isActive = true
    } else {
      bodyView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor).isActive = true
    }

  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension DemoStackScrollViewController {

  final class Component: ASDisplayNode {

    private let textNode = ASTextNode()

    override init() {
      super.init()

      automaticallyManagesSubnodes = true

      backgroundColor = .orange

      textNode.attributedText = NSAttributedString(string: """
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
""")
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
      LayoutSpec {
        textNode
      }
    }

  }

  final class FlexWrapComponent: ASDisplayNode {

    private let nodes: [ASTextNode]

    override init() {

      let nodes = (0..<30).map { i -> ASTextNode in
        let text = ASTextNode()
        text.attributedText = NSAttributedString(string: "Hello")
        return text
      }

      self.nodes = nodes

      super.init()

      backgroundColor = .red

      automaticallyManagesSubnodes = true

    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
      LayoutSpec {
        HStackLayout(spacing: 0, justifyContent: .start, alignItems: .center, flexWrap: .wrap(lineSpacing: 10, alignContent: .start), isConcurrent: false) {
          nodes
        }
      }
    }

  }

  final class HorizontalNoWrapComponent: ASDisplayNode {

    private let nodes: [ASTextNode]

    override init() {

      let nodes = (0..<30).map { i -> ASTextNode in
        let text = ASTextNode()
        text.attributedText = NSAttributedString(string: "Hello")
        return text
      }

      self.nodes = nodes

      super.init()

      backgroundColor = .orange

      automaticallyManagesSubnodes = true

    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
      LayoutSpec {
        HStackLayout(spacing: 0, justifyContent: .start, alignItems: .center, flexWrap: .wrap(lineSpacing: 10, alignContent: .start), isConcurrent: false) {
          nodes
        }
      }
    }

  }

}
