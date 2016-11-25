import UIKit

class SplashViewController: UIViewController {

  @IBOutlet weak var spinner: UIActivityIndicatorView!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    spinner.activityIndicatorViewStyle = .whiteLarge
    spinner.color = UIColor.darkGray
    spinner.startAnimating()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}
