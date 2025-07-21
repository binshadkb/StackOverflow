//
//  UserTableViewCell.swift
//  StackOverflow
//
//  Created by Binshad Karekkatt Basheer on 21/07/2025.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    static let identifier = "UserTableViewCell"
    
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let reputationLabel = UILabel()
    private let followButton = UIButton(type: .system)
    
    private var userId: Int?
    var onFollowToggle: ((Int) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        reputationLabel.translatesAutoresizingMaskIntoConstraints = false
        followButton.translatesAutoresizingMaskIntoConstraints = false
        
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        reputationLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        reputationLabel.textColor = .darkGray
        
        followButton.addTarget(self, action: #selector(followButtonTapped), for: .touchUpInside)
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(reputationLabel)
        contentView.addSubview(followButton)
        
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),
            nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            
            reputationLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            reputationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            
            followButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            followButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            reputationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with user: User, isFollowed: Bool) {
        userId = user.id
        
        nameLabel.text = user.name
        reputationLabel.text = "Reputation: \(user.reputation)"
        
        if let imageUrl = user.profileImage, let url = URL(string: imageUrl) {
            loadImage(from: url)
        } else {
            profileImageView.image = UIImage(systemName: "person.circle")
        }
        
        updateFollowButton(isFollowed: isFollowed)
    }
    
    private func updateFollowButton(isFollowed: Bool) {
        let title = isFollowed ? "Unfollow" : "Follow"
        followButton.setTitle(title, for: .normal)
        followButton.setTitleColor(isFollowed ? .systemRed : .systemBlue, for: .normal)
    }
    
    @objc private func followButtonTapped() {
        guard let userId = userId else { return }
        onFollowToggle?(userId)
    }
    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.profileImageView.image = UIImage(data: data)
            }
        }.resume()
    }
}
