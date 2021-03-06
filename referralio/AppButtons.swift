//
//  AppButtons.swift
//  referralio
//
//  Created by Kazuyuki Tanimura on 4/12/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

protocol AppButtonDelegate { // TODO user protocol extension not to require all these functions
  func saved()
  func drafted()
  func canceled()
  func next()
  func prev()
  func offer()
  func forward()
}

class AppButton: UIButton {
  var delegate: AppButtonDelegate?

  init(delegate: AppButtonDelegate?) {
    super.init(frame: CGRectMake(0, 0, 0, 0))
    self.delegate = delegate
    layer.masksToBounds = true
    layer.cornerRadius = 4.0
    layer.borderWidth = 1
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

class SaveButton: AppButton {
  override init(delegate: AppButtonDelegate?) {
    super.init(delegate: delegate)
    backgroundColor = AppColors.Orange
    setTitle("Save", forState: .Normal)
    setTitleColor(AppColors.White, forState: .Normal)
    layer.borderColor = AppColors.Orange.CGColor
    addTarget(self, action: "onClickButton:", forControlEvents: .TouchUpInside)
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func onClickButton(sender: UIButton) {
    delegate?.saved()
  }
}

class DraftButton: AppButton {
  override init(delegate: AppButtonDelegate?) {
    super.init(delegate: delegate)
    setTitle("Save as draft", forState: .Normal)
    setTitleColor(AppColors.Orange, forState: .Normal)
    layer.borderColor = AppColors.Orange.CGColor
    addTarget(self, action: "onClickButton:", forControlEvents: .TouchUpInside)
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func onClickButton(sender: UIButton) {
    delegate?.drafted()
  }
}

class CancelButton: AppButton {
  override init(delegate: AppButtonDelegate?) {
    super.init(delegate: delegate)
    setTitle("Cancel", forState: .Normal)
    setTitleColor(AppColors.DarkGray, forState: .Normal)
    layer.borderColor = AppColors.DarkGray.CGColor
    addTarget(self, action: "onClickButton:", forControlEvents: .TouchUpInside)
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func onClickButton(sender: UIButton) {
    delegate?.canceled()
  }
}

class NextButton: AppButton {
  override init(delegate: AppButtonDelegate?) {
    super.init(delegate: delegate)
    setTitle("Next", forState: .Normal)
    setTitleColor(AppColors.Orange, forState: .Normal)
    layer.borderColor = AppColors.Orange.CGColor
    addTarget(self, action: "onClickButton:", forControlEvents: .TouchUpInside)
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func onClickButton(sender: UIButton) {
    delegate?.next()
  }
}

class PrevButton: AppButton {
  override init(delegate: AppButtonDelegate?) {
    super.init(delegate: delegate)
    setTitle("Prev", forState: .Normal)
    setTitleColor(AppColors.Orange, forState: .Normal)
    layer.borderColor = AppColors.Orange.CGColor
    addTarget(self, action: "onClickButton:", forControlEvents: .TouchUpInside)
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func onClickButton(sender: UIButton) {
    delegate?.prev()
  }
}

class UpdatePhotoButton: AppButton {
  let activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
  var idOfPhoto: String?

  init(idOfPhoto: String) {
    super.init(delegate: nil)
    self.idOfPhoto = idOfPhoto
    setTitle("Update photo", forState: .Normal)
    setTitleColor(AppColors.Orange, forState: .Normal)
    titleLabel!.font = AppFonts.boldFont
    layer.borderColor = AppColors.Orange.CGColor
    addTarget(self, action: "onClickButton:", forControlEvents: .TouchUpInside)
    activityView.frame = CGRect(x: 8, y: 4, width: 25, height: 25)
    activityView.startAnimating()
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func onClickButton(sender: UIButton) {
    addSubview(activityView)
    let photoView = self.getSiblingView(self.idOfPhoto) as? UIImageView
    let photoController = PhotoController(photoView: photoView)
    addSubview(photoController.view)
    photoController.presentViewController(activityView.removeFromSuperview)
  }
}

class OfferButton: AppButton {
  override init(delegate: AppButtonDelegate?) {
    super.init(delegate: delegate)
    backgroundColor = AppColors.Orange
    setTitle("Introduce a job", forState: .Normal)
    setTitleColor(AppColors.White, forState: .Normal)
    layer.borderColor = AppColors.Orange.CGColor
    addTarget(self, action: "onClickButton:", forControlEvents: .TouchUpInside)
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func onClickButton(sender: UIButton) {
    delegate?.offer()
  }
}

class ForwardButton: AppButton {
  override init(delegate: AppButtonDelegate?) {
    super.init(delegate: delegate)
    setTitle("Forward to friends", forState: .Normal)
    setTitleColor(AppColors.Orange, forState: .Normal)
    layer.borderColor = AppColors.Orange.CGColor
    addTarget(self, action: "onClickButton:", forControlEvents: .TouchUpInside)
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func onClickButton(sender: UIButton) {
    delegate?.forward()
  }
}