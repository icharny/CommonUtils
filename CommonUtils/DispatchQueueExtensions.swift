public extension DispatchQueue {
    func asyncAfter(_ timeInterval: DispatchTimeInterval, execute: @escaping () -> Void) {
        asyncAfter(deadline: .now() + timeInterval, execute: execute)
    }
    
    func asyncAfter(_ timeInterval: DispatchTimeInterval, execute: DispatchWorkItem) {
        asyncAfter(deadline: .now() + timeInterval, execute: execute)
    }
}
