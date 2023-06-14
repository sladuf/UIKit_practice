
import UIKit

class CustomTableViewCell : UITableViewCell {
    static let id = "CustomTableViewCell"
    
    private var label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initAttribute()
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initAttribute(){
        backgroundColor = .clear
        label.textColor = .black
    }
    
    func initLayout(){
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func bind(_ item: Item){
        label.text = item.title
    }

}
