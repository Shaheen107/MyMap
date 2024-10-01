import Foundation
import CoreLocation

struct Destination: Codable {
    let name: String
    let coordinate: CLLocationCoordinate2D
}
