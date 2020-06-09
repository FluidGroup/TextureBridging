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

    stackScrollView.append(view: NodeView(node: Component()))

    stackScrollView.append(view: NodeView(node: FlexWrapComponent()))
  }
}

extension DemoStackScrollViewController {

  final class Component: ASDisplayNode {

    private let textNode = ASTextNode()

    override init() {
      super.init()

      automaticallyManagesSubnodes = true

      textNode.attributedText = NSAttributedString(string: "Fooooooooooooooooooooooooooooo")
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
