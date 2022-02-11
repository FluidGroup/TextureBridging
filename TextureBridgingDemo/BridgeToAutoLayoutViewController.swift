//
//  ViewController.swift
//  TextureBridgingDemo
//
//  Created by muukii on 2019/05/15.
//  Copyright © 2019 muukii. All rights reserved.
//

import AsyncDisplayKit
import MondrianLayout
import TextureBridging
import TypedTextAttributes
import UIKit

final class BridgeToAutoLayoutViewController: UIViewController {

  private let nodeView = NodeView(node: ComponentNode())

  override func viewDidLoad() {
    super.viewDidLoad()

    let changeTextButton = UIButton(type: .system)
    changeTextButton.setTitle("Change Text", for: .normal)

    let refreshButton = UIButton(type: .system)
    refreshButton.setTitle("Refresh", for: .normal)

    view.backgroundColor = .white

    view.mondrian.buildSubviews {
      LayoutContainer(attachedSafeAreaEdges: .all) {
        VStackBlock(alignment: .fill) {

          nodeView
            .viewBlock
            .padding(.horizontal, 32)

          StackingSpacer(minLength: 32)

          changeTextButton
          refreshButton
        }
      }
    }

    changeTextButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
    refreshButton.addTarget(self, action: #selector(refresh), for: .touchUpInside)
  }

  @objc
  private dynamic func didTap() {

    nodeView.node.set(text: Lorem.ipsum(Int(arc4random_uniform(500) + 10)))
  }

  @objc
  private dynamic func refresh() {

    nodeView.invalidateIntrinsicContentSize()
  }
}

final class ComponentNode: ASDisplayNode {

  private let textNode = ASTextNode()

  override init() {
    super.init()

    backgroundColor = UIColor(white: 0.8, alpha: 1)
    automaticallyManagesSubnodes = true
  }

  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

    return ASInsetLayoutSpec(
      insets: .zero,
      child: textNode
    )
  }

  func set(text: String) {

    textNode.attributedText = text.attributed {
      TextAttributes()
        .font(UIFont.preferredFont(forTextStyle: .headline))
        .foregroundColor(UIColor(white: 0.1, alpha: 1))
    }

  }
}
