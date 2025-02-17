//
//  DemoStackScrollViewController.swift
//  TextureBridgingDemo
//
//  Created by muukii on 2020/06/09.
//  Copyright © 2020 muukii. All rights reserved.
//

import Foundation
import MondrianLayout
import StackScrollView
import TextureSwiftSupport
import TextureBridging

final class DemoStackScrollViewController: UIViewController {

  private let stackScrollView = StackScrollView()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(stackScrollView)

    Mondrian.buildSubviews(on: view) {
      ZStackBlock(alignment: .attach(.all)) {
        stackScrollView
      }
    }

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

      backgroundColor = .orange.withAlphaComponent(0.5)

      textNode.attributedText = NSAttributedString(
        string: """
        Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
        """,
        attributes: [
          .foregroundColor: UIColor.init {
            switch $0.userInterfaceStyle {
            case .light:
              return .black
            case .dark:
              return .white
            case .unspecified:
              return .black
            @unknown default:
              return .black
            }
          }
        ]
      )
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
        text.attributedText = NSAttributedString(
          string: "Hello",
          attributes: [
            .foregroundColor: UIColor.init {
              switch $0.userInterfaceStyle {
              case .light:
                return .systemBlue
              case .dark:
                return .systemGreen
              case .unspecified:
                return .systemBlue
              @unknown default:
                return .systemBlue
              }
            }
          ]
        )
        return text
      }

      self.nodes = nodes

      super.init()

      backgroundColor = .red.withAlphaComponent(0.5)

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
