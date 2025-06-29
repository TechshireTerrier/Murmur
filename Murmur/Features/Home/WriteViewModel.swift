import SwiftUI

class WriteViewModel: ObservableObject {
    @Published var userText: String = ""
    @Published var showFailAlert: Bool = false
}
