import XCTest
@testable import alloca
import calloca

final class allocaTests: XCTestCase {
  func testExample() throws {
    let bufferContents = (0..<3).lazy.map { x in 3.14 * Double(x + 1)}
    XCTAssertEqual(useAlloca(), String(bufferContents.reduce(0, +)))
  }
}
