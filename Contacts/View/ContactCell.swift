import UIKit
import SnapKit
import Kingfisher

class ContactCell: UITableViewCell {
    
    var viewModel: ContactViewModel? {
        didSet {
            contactImage.image = UIImage(named: "avatar")
            if let id = viewModel?.id, let imgUrl = UserDefaults.standard.url(forKey: String(id)) {
                contactImage.kf.setImage(with: imgUrl, placeholder: UIImage(named: "avatar"))
            }
            nameLabel.text = viewModel?.fullName
        }
    }
    
    private let contactImage: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 20
        return imgView
    }()
    
    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(nameLabel)
        addSubview(contactImage)
        
        contactImage.snp.makeConstraints { make in
            make.height.equalTo(contactImage.snp.width)
            make.left.equalToSuperview().offset(17)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
