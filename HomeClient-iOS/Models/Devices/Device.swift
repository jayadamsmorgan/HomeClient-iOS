import Foundation

protocol Device: Hashable, Identifiable, Codable {
    var id: Int { get set }
    var name: String { get set }
    var on: Bool { get set }
}
