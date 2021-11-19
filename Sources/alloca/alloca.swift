import calloca

public func useAlloca() -> String {
  struct Passthru {
    var count: Int = 3
    var output: String? = nil
  }

  var pt = Passthru()
  c_alloca(256 * MemoryLayout<Double>.size, &pt) {
    p, newMemory in
    let io = p.assumingMemoryBound(to: Passthru.self)
    let count = io.pointee.count

    let buffer = UnsafeMutableBufferPointer(
      start: newMemory.bindMemory(to: Double.self, capacity: 256),
      count: count)

    // Construct some values in the buffer.  For Double you /could/ just assign,
    // but initialize will work for any type.
    _ = buffer.initialize(
      from: (0..<count).lazy.map { x in 3.14 * Double(x + 1)})

    // Construct a "return value" by summing what's in the buffer.
    io.pointee.output = String(buffer.reduce(0, +))

    // Not needed for doubles but will make this code work for other types.
    if let b = buffer.baseAddress {
      b.deinitialize(count: count)
    }
  }
  return pt.output!
}
