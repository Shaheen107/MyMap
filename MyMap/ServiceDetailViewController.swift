import UIKit

class ServiceDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var serviceTitle: String?
    var serviceSubtitle: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = serviceTitle
        subtitleLabel.text = serviceSubtitle
    }
}
