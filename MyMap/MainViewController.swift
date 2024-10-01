import UIKit
import MapKit
import CoreLocation

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var destinations: [Destination] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadDestinations()
    }

    @IBAction func addDestination(_ sender: Any) {
        let addVC = AddDestinationViewController()
        addVC.delegate = self
        present(addVC, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return destinations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "destinationCell", for: indexPath)
        cell.textLabel?.text = destinations[indexPath.row].name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mapVC = MapViewController()
        mapVC.destination = destinations[indexPath.row]
        navigationController?.pushViewController(mapVC, animated: true)
    }

    func saveDestinations() {
        if let data = try? JSONEncoder().encode(destinations) {
            UserDefaults.standard.set(data, forKey: "destinations")
        }
    }

    func loadDestinations() {
        if let data = UserDefaults.standard.data(forKey: "destinations"),
           let savedDestinations = try? JSONDecoder().decode([Destination].self, from: data) {
            destinations = savedDestinations
        }
    }
}

extension MainViewController: AddDestinationDelegate {
    func didAddDestination(_ destination: Destination) {
        destinations.append(destination)
        tableView.reloadData()
        saveDestinations()
    }
}
