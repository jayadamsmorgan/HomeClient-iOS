import Foundation

protocol Device: Hashable, Identifiable, Codable {
    var id: String { get set }
    var name: String { get set }
    var on: Bool { get set }
}
