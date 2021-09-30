import StorybookKit
import StorybookKitTextureSupport
import TextureSwiftSupport

let book = Book(title: "Book") {
  BookPush(title: "Text") {
    BridgeToAutoLayoutViewController()
  }
  BookPush(title: "Text - unconstrained") {
    DemoUnconstrainedViewController()
  }
  BookPush(title: "Image") {
    DemoImageViewController()
  }
  BookPush(title: "StackScroll") {
    DemoStackScrollViewController()
  }
}
