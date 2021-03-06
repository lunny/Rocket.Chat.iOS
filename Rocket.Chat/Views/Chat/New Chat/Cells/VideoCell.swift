//
//  VideoMessageCell.swift
//  Rocket.Chat
//
//  Created by Rafael Streit on 28/09/18.
//  Copyright © 2018 Rocket.Chat. All rights reserved.
//

import UIKit
import AVFoundation
import RocketChatViewController

final class VideoCell: BaseVideoMessageCell, SizingCell {
    static let identifier = String(describing: VideoCell.self)

    static let sizingCell: UICollectionViewCell & ChatCell = {
        guard let cell = VideoCell.instantiateFromNib() else {
            return VideoCell()
        }

        return cell
    }()

    override var loading: Bool {
        didSet {
            updateLoadingState(with: buttonPlayer, and: activityIndicatorView)
        }
    }

    @IBOutlet weak var labelDescriptionTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var imageViewThumb: UIImageView! {
        didSet {
            imageViewThumb.layer.cornerRadius = 4
            imageViewThumb.clipsToBounds = true
        }
    }

    @IBOutlet weak var buttonPlayer: UIButton!
    @IBOutlet weak var labelDescription: UILabel!

    override func configure() {
        guard let viewModel = viewModel?.base as? VideoMessageChatItem else {
            return
        }

        if let description = viewModel.descriptionText, !description.isEmpty {
            labelDescription.text = description
            labelDescriptionTopConstraint.constant = 10
        } else {
            labelDescription.text = ""
            labelDescriptionTopConstraint.constant = 0
        }

        updateVideo(with: imageViewThumb)
    }

    @IBAction func buttonPlayDidPressed(_ sender: Any) {
        // delegate?.openVideoFromCell(attachment: attachment)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        imageViewThumb.image = nil
        loading = false
    }
}

extension VideoCell {
    override func applyTheme() {
        super.applyTheme()

        let theme = self.theme ?? .light
        labelDescription.textColor = theme.controlText
    }
}
