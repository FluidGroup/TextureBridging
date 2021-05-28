//
//  DemoImageViewController.swift
//  TextureBridgingDemo
//
//  Created by muukii on 2019/09/02.
//  Copyright © 2019 muukii. All rights reserved.
//

import UIKit

import AsyncDisplayKit
import TextureBridging
import EasyPeasy

final class DemoImageViewController: UIViewController {
  
  private let imageView = NodeView(node: ASImageNode())
  private let button = UIButton(type: .system)
  private var flag = true
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    button.setTitle("Switch", for: .normal)
    
    view.addSubview(imageView)
    view.addSubview(button)
    
    imageView.easy.layout(Center())
    
    button.easy.layout([CenterX(), Bottom(40)])
    
    button.addTarget(self, action: #selector(tap), for: .touchUpInside)
  }
  
  @objc
  private func tap() {
    if flag {
      imageView.node.image = UIImage(named: "v")
    } else {
      imageView.node.image = UIImage(named: "h")
    }
    flag.toggle()
    
    imageView.node.setNeedsLayout()
    imageView.node.layoutIfNeeded()
    imageView.invalidateIntrinsicContentSize()
  }
}
