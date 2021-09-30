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

final class DemoUnconstrainedViewController: UIViewController {

  private let nodeView = NodeView(node: ComponentNode())

  override func viewDidLoad() {
    super.viewDidLoad()

    let changeTextButton = UIButton(type: .system)
    changeTextButton.setTitle("Change Text", for: .normal)

    let refreshButton = UIButton(type: .system)
    refreshButton.setTitle("Refresh", for: .normal)

    view.backgroundColor = .white

    view.addSubview(nodeView)
    view.addSubview(changeTextButton)

    mondrianBatchLayout {
      nodeView.mondrian.layout
        .top(.to(view.safeAreaLayoutGuide))
        .horizontal(.to(view.safeAreaLayoutGuide), 32)

      changeTextButton.mondrian.layout
        .bottom(.to(view.safeAreaLayoutGuide), -20)
        .centerX(.toSuperview)
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
