import UIKit
import MapKit

protocol AddDestinationDelegate: AnyObject {
    func didAddDestination(_ destination: Destination)
}

class AddDestinationViewController: UIViewController, MKMapViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nameTextField: UITextField!
    weak var delegate: AddDestinationDelegate?
    var selectedCoordinate: CLLocationCoordinate2D?

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }

    @IBAction func saveDestination(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty, let coordinate = selectedCoordinate else {
            // Show error
            return
        }
        let destination = Destination(name: name, coordinate: coordinate)
        delegate?.didAddDestination(destination)
        dismiss(animated: true, completion: nil)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else { return }
            let coordinate = response.mapItems.first?.placemark.coordinate
            self.selectedCoordinate = coordinate
            if let coordinate = coordinate {
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = searchText
                self.mapView.addAnnotation(annotation)
                self.mapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), animated: true)
            }
        }
    }
}
