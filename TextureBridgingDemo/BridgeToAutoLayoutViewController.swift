//
//  ViewController.swift
//  TextureBridgingDemo
//
//  Created by muukii on 2019/05/15.
//  Copyright © 2019 muukii. All rights reserved.
//

import UIKit

import EasyPeasy
import TextureBridging
import AsyncDisplayKit
import TypedTextAttributes

final class BridgeToAutoLayoutViewController : UIViewController {
  
  private let changeTextButton = UIButton(type: .system)
  private let nodeView = NodeView(node: ComponentNode())
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    changeTextButton.setTitle("Change Text", for: .normal)
    
    view.backgroundColor = .white
    view.addSubview(changeTextButton)
    view.addSubview(nodeView)
    
    changeTextButton.easy.layout([
      CenterX(),
      Bottom(32).to(view.safeAreaLayoutGuide, .bottom)
      ])
    
    nodeView.easy.layout([
      Top(32).to(view.safeAreaLayoutGuide, .top),
      CenterX(),
      Left(>=32),
      Right(<=32),
      Bottom(<=0).to(changeTextButton, .top),
      ])
    
    changeTextButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
  }
  
  @objc
  private dynamic func didTap() {
    
    nodeView.node.set(text: Lorem.ipsum(Int(arc4random_uniform(500) + 10)))
  }
}

extension BridgeToAutoLayoutViewController {
  
  private final class ComponentNode : ASDisplayNode {
    
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
}
