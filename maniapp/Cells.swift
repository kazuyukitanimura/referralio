//
//  Cells.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 3/30/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

extension UIImageView {
  var toCircle:Bool {
    get {
      return layer.cornerRadius == frame.size.width / 2 && clipsToBounds
    }
    set (value) {
      if (value) {
        layer.cornerRadius = frame.size.width / 2
        clipsToBounds = true
      } else {
        layer.cornerRadius = 0
        clipsToBounds = false
      }
    }
  }
}

let titleFont = UIFont.systemFontOfSize(17.0)
let subTitleFont = UIFont.systemFontOfSize(12.0)
let profileSize:CGFloat = 56
var cells:[ConstrainedViews] = [
  // 0
  ConstrainedViews(views: [
    "title": [
      "text": "Kazuyuki Tanimura",
      "font": titleFont,
      "textColor": AppColors.Orange,
    ],
    "subTitle": [
      "text": "Member of Technical Staff at BloomReach, Inc.",
      "font": subTitleFont,
      "textColor": AppColors.DarkGray,
    ],
    "photo": [
      "image": "profile-rabbit-toy.png",
      "frame": NSValue(CGRect: CGRectMake(0, 0, profileSize, profileSize)),
      "toCircle": true,
    ],
    "preview": UIView(),
    ], formats: [
      "H:|-8-[photo(\(profileSize))]-8-[title]-8-|",
      "H:|-8-[photo(\(profileSize))]-8-[subTitle]-8-|",
      "H:|-8-[preview]-8-|",
      "V:|-8-[title]-2-[subTitle]-(>=8)-|",
      "V:|-8-[photo(\(profileSize))]-4-[preview]-(>=4)-|",
    ]),
  // 1
  ConstrainedViews(views: [
    "title": [
      "text": "Referral Center",
      "font": titleFont,
      "textColor": AppColors.Orange,
    ],
    "subTitle": [
      "text": "Check your referral status or Update your interview status",
      "font": subTitleFont,
      "textColor": AppColors.DarkGray,
    ],
    "preview": UIView(),
    ], formats: [
      "H:|-8-[title]-8-|",
      "H:|-8-[subTitle]-8-|",
      "H:|-8-[preview]-8-|",
      "V:|-8-[title]-2-[subTitle]-4-[preview]-(>=4)-|",
    ]),
  // 2
  ConstrainedViews(views: [
    "title": [
      "text": "Notifications",
      "font": titleFont,
      "textColor": AppColors.Orange,
    ],
    "subTitle": [
      "text": "0 new notifications",
      "font": subTitleFont,
      "textColor": AppColors.DarkGray,
    ],
    "preview": UIView(),
    ], formats: [
      "H:|-8-[title]-8-|",
      "H:|-8-[subTitle]-8-|",
      "H:|-8-[preview]-8-|",
      "V:|-8-[title]-2-[subTitle]-4-[preview]-(>=4)-|",
    ]),
  // 3
  ConstrainedViews(views: [
    "title": [
      "text": "News Feed 1",
      "font": titleFont,
      "textColor": AppColors.Orange,
    ],
    "preview": UIView(),
    ], formats: [
      "H:|-8-[title]-8-|",
      "H:|-8-[preview]-8-|",
      "V:|-8-[title]-4-[preview]-(>=4)-|",
    ]),
  // 4
  ConstrainedViews(views: [
    "title": [
      "text": "News Feed 2",
      "font": titleFont,
      "textColor": AppColors.Orange,
    ],
    "preview": UIView(),
    ], formats: [
      "H:|-8-[title]-8-|",
      "H:|-8-[preview]-8-|",
      "V:|-8-[title]-4-[preview]-(>=4)-|",
    ]),
]