import Foundation

protocol Device: Hashable, Identifiable, Codable {
    var id: Int { get set }
    var name: String { get set }
    var location: Location { get }
    var data: String { get set }
    var ipAddress: String { get set }
    var on: Bool { get set }
}
