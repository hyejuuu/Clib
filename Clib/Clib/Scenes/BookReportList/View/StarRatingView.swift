//
//  StarRatingView.swift
//  Clib
//
//  Created by 이혜주 on 2020/07/23.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

enum StarColor {
    case yellow
    case keyColor
}

class StarRatingView: UIView {
    
    let step: Float = 0.5
    var starColor: StarColor = .yellow
    var isEnabled: Bool = true
    var rating: Float = 0.0 {
        didSet {
            setupStarImageViews()
        }
    }
    
    var ratingCallback: ((Float)->())?
    
    private lazy var fullImage = starColor == .yellow ? UIImage(named: "iconStarYellow") : UIImage(named: "iconStarPrimary")
    private let emptyImage = UIImage(named: "iconStarGray")
    private lazy var halfImage = starColor == .yellow ? UIImage(named: "iconStarYellowHalf") : UIImage(named: "iconStarPrimaryHalf")
    
    private let starStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let ratingSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        slider.maximumTrackTintColor = .clear
        slider.minimumTrackTintColor = .clear
        slider.thumbTintColor = .clear
        slider.maximumValue = 5.0
        return slider
    }()
    
    private lazy var imageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tag = 1
        imageView.image = emptyImage
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var imageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tag = 2
        imageView.image = emptyImage
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var imageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tag = 3
        imageView.image = emptyImage
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var imageView4: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tag = 4
        imageView.image = emptyImage
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var imageView5: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tag = 5
        imageView.image = emptyImage
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init(color: StarColor, isEnabled: Bool, rating: Float = 0.0) {
        self.starColor = color
        self.isEnabled = isEnabled
        self.rating = rating
        
        super.init(frame: .zero)
        setupLayout()
        setupStarImageViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStarImageViews() {
        if starStackView.arrangedSubviews.isEmpty {
            starStackView.addArrangedSubview(imageView1)
            starStackView.addArrangedSubview(imageView2)
            starStackView.addArrangedSubview(imageView3)
            starStackView.addArrangedSubview(imageView4)
            starStackView.addArrangedSubview(imageView5)
        }
        
        for tag in 1...5 {
            if let imageView = starStackView.viewWithTag(tag) as? UIImageView {
                if Float(tag) <= rating {
                    imageView.image = fullImage
                } else if rating - Float(tag - 1) > 0.0, rating - Float(tag - 1) <= 0.5 {
                    imageView.image = halfImage
                } else {
                    imageView.image = emptyImage
                }
            }
        }
    }
    
    private func setupLayout() {
        ratingSlider.isUserInteractionEnabled = isEnabled
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(sliderTapValueChanged))
        
        addSubview(starStackView)
        addSubview(ratingSlider)
        
        ratingSlider.addGestureRecognizer(tapGestureRecognizer)
        
        starStackView.leadingAnchor.constraint(
            equalTo: leadingAnchor).isActive = true
        starStackView.trailingAnchor.constraint(
            equalTo: trailingAnchor).isActive = true
        starStackView.topAnchor.constraint(
            equalTo: topAnchor).isActive = true
        starStackView.bottomAnchor.constraint(
            equalTo: bottomAnchor).isActive = true
        
        ratingSlider.leadingAnchor.constraint(
            equalTo: starStackView.leadingAnchor).isActive = true
        ratingSlider.trailingAnchor.constraint(
            equalTo: starStackView.trailingAnchor).isActive = true
        ratingSlider.topAnchor.constraint(
            equalTo: starStackView.topAnchor).isActive = true
        ratingSlider.bottomAnchor.constraint(
            equalTo: starStackView.bottomAnchor).isActive = true
        
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        let value = round(sender.value / step) * step
        
        for tag in 1...5 {
            if let imageView = starStackView.viewWithTag(tag) as? UIImageView {
                if value <= Float(tag) - 0.5, value > Float(tag) - 1 {
                    imageView.image = halfImage
                } else if value > Float(tag) - 0.5 {
                    imageView.image = fullImage
                } else {
                    imageView.image = emptyImage
                }
            }
        }
        
        ratingCallback?(value)
    }
    
    @objc private func sliderTapValueChanged(_ gestureRecognizer: UIGestureRecognizer) {
        let pointTapped: CGPoint = gestureRecognizer.location(in: self)

        let positionOfSlider: CGPoint = ratingSlider.frame.origin
        let widthOfSlider: CGFloat = ratingSlider.frame.size.width
        let newValue = ((pointTapped.x - positionOfSlider.x) * CGFloat(ratingSlider.maximumValue) / widthOfSlider)

        ratingSlider.setValue(Float(newValue), animated: true)
        
        let value = round(Float(newValue) / step) * step
        
        for tag in 1...5 {
            if let imageView = starStackView.viewWithTag(tag) as? UIImageView {
                if value <= Float(tag) - 0.5, value > Float(tag) - 1 {
                    imageView.image = halfImage
                } else if value > Float(tag) - 0.5 {
                    imageView.image = fullImage
                } else {
                    imageView.image = emptyImage
                }
            }
        }
        
        ratingCallback?(value)
    }

}
