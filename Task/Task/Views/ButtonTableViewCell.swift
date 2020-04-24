import UIKit


class ButtonTableViewCell: UITableViewCell {
    weak var delegate: ButtonTableViewCellDelegate?
    
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        guard let delegate = delegate else { return }
        delegate.buttonCellButtonTapped(self)
    }
    func updateButton(isComplete: Bool) {
        
    }
    
} // ends class


extension ButtonTableViewCell {
    
    fileprivate func updateButton(_ isComplete: Bool) {
        let image = isComplete ? "complete" : "incomplete"
        completeButton.setImage(UIImage(named: image), for: .normal)
    }
}
protocol ButtonTableViewCellDelegate: class {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell)
}
