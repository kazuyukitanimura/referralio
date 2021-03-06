//
//  CenterViewController.swift
//  referralio
//
//  Created by Kazuyuki Tanimura on 3/25/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

class CenterViewController: UITableViewController, ProfileViewControllerDelegate {
  lazy var searchBar = UISearchBar()
  let cellIdentifier = "Cell"
  let headerFooterHight:CGFloat = 4

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = AppColors.Gray
    tableView?.separatorStyle = .None
    tableView?.registerClass(CenterViewCell.self, forCellReuseIdentifier: cellIdentifier)
    tableView?.estimatedRowHeight = 68
    tableView?.rowHeight = UITableViewAutomaticDimension
    tableView?.tableHeaderView = UIView(frame: CGRectMake(0, 0, headerFooterHight, headerFooterHight))
    tableView?.tableHeaderView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapTableHeader:"))
  }

  override func didMoveToParentViewController(parent: UIViewController?) {
    super.didMoveToParentViewController(parent)
    navigationController!.navigationBar.barTintColor = AppColors.Orange
    navigationController!.navigationBar.tintColor = AppColors.White
    navigationController!.hidesBarsOnSwipe = true
    navigationController!.barHideOnSwipeGestureRecognizer.addTarget(self, action: "handleHideOnSwipe:")
    searchBar.placeholder = "Search friends, updates, referrals"
    searchBar.tintColor = AppColors.White
    searchBar.searchBarStyle = .Minimal
    searchBar.setImage(UIImage(named: "search2.png"), forSearchBarIcon: UISearchBarIcon.Search, state: UIControlState.Normal)
    searchBar.setImage(UIImage(named: "clear.png"), forSearchBarIcon: UISearchBarIcon.Clear, state: UIControlState.Normal)
    let searchField = searchBar.valueForKey("searchField") as! UITextField
    searchField.textColor = AppColors.White
    searchField.attributedPlaceholder = NSAttributedString(string:searchField.placeholder!, attributes: [NSForegroundColorAttributeName: AppColors.White])
    searchBar.frame = CGRectMake(0, 0, view.frame.maxX * 0.78, 20) // FIXME any better way to adjust the width?
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView:searchBar)
  }

  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    //removeFromParentViewController() // FIXME not removing from parents since we do not want to recreate the navigation bar
  }

  func handleHideOnSwipe(recognizer: UISwipeGestureRecognizer) {
    // hide the status bar for up swipes, show it for down swipes
    let hideStatusBar = navigationController!.navigationBar.frame.minY < -headerFooterHight
    UIApplication.sharedApplication().setStatusBarHidden(hideStatusBar, withAnimation: .Fade)
    if (!hideStatusBar) {
      automaticallyAdjustsScrollViewInsets = true
    }
  }

  func tapTableHeader(recognizer: UITapGestureRecognizer) {
    // empty function to swallow the default behavior, which is showing the navigation bar
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cells.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CenterViewCell
    var constrainedView = cells[indexPath.row]
    if (indexPath.row == 0) {
      let me = Models.getMe()
      constrainedView.updateViews([
        "title": [
          "text": (me.firstName.isEmpty && me.lastName.isEmpty) ? "Your Name" : "\(me.firstName) \(me.lastName)",
        ],
        "subTitle": [
          "text": (me.currentTitle.isEmpty && me.currentAffiliation.isEmpty) ? "Tap to pdate your title and affiliation" : (me.currentTitle.isEmpty || me.currentAffiliation.isEmpty) ? "\(me.currentTitle)\(me.currentAffiliation)" : "\(me.currentTitle) at \(me.currentAffiliation)",
        ],
        "photo": [
          "image": me.photo ?? "defaultProfile2.png",
        ],
      ])
    } else if (indexPath.row == 3) { // TODO the row number could be different
      let me = Models.getMe()
      let referee = Models.getProfile(3) // TODO change to user id
      constrainedView.updateViews([
        "title": [
          "text": "\(referee.firstName) Asked for a Referral",
        ],
        "to": [
          "image": me.photo ?? "defaultProfile2.png",
        ],
        "from": [
          "image": referee.photo ?? "defaultProfile2.png",
        ],
      ])
    }
    cell.innerView.addConstrainedViews(constrainedView)
    cell.indexPath = indexPath
    cell.delegate = self
    if (indexPath.section == tableView.numberOfSections() - 1  && indexPath.row == tableView.numberOfRowsInSection(indexPath.section) - 1) {
      // pad the footer in order to allow scrolling the last row to the top of the screen
      tableView.tableFooterView = UIView(frame: CGRectMake(0, 0, headerFooterHight, max(headerFooterHight, tableView.bounds.height - cell.bounds.maxY - headerFooterHight)))
    }
    return cell
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    /*
    let cell = tableView.cellForRowAtIndexPath(indexPath) as CenterViewCell
    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
      Animations.bloat(cell.innerView)
    })
    */
    UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .Fade)
    navigationController!.setNavigationBarHidden(true, animated: true)
    automaticallyAdjustsScrollViewInsets = false
    var constrainedView = cells[indexPath.row]
    if (constrainedView.state == CellState.Collapsed) {
      scrollToRowAtIndexPath(indexPath)
      constrainedView.state = .Expanded
      var previewViewController: PreviewViewController!
      if (indexPath.row == 0) {
        previewViewController = ProfileViewController(delegate: self, indexPath: indexPath)
      } else if (indexPath.row == 1) {
        previewViewController = FriendsViewController()
      } else if (indexPath.row == 3) {
        previewViewController = ReferralViewController()
      } else {
        previewViewController = PreviewViewController()
      }
      constrainedView.updateViews([
        "preview": previewViewController,
      ])
      updateSingleRow(indexPath)
    }
  }

  func updateSingleRow(indexPath: NSIndexPath) {
    tableView.beginUpdates()
    tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    tableView.endUpdates()
  }

  func scrollToRowAtIndexPath(indexPath: NSIndexPath, onlyWhenNegative: Bool=false) {
    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
      let offsetY = self.tableView.rectForRowAtIndexPath(indexPath).minY - self.headerFooterHight
      if (onlyWhenNegative ? (self.tableView.contentOffset.y >= offsetY) : (self.tableView.contentOffset.y != offsetY)) {
        self.navigationController!.setNavigationBarHidden(true, animated: false)
        self.tableView.setContentOffset(CGPointMake(0, offsetY), animated: true)
      }
    })
  }

  func save(indexPath: NSIndexPath, profile: Profile) {
    var constrainedView = cells[indexPath.row]
    if (constrainedView.state == CellState.Expanded) {
      if let profileViewController = constrainedView.views["preview"] as? ProfileViewController {
        profileViewController.save(profile)
      }
    }
  }
  func saved(indexPath: NSIndexPath) {
    save(indexPath, profile: Models.getMe())
    drafted(indexPath)
  }
  func drafted(indexPath: NSIndexPath) {
    save(indexPath, profile: Models.getDraftMe())
    canceled(indexPath)
  }
  func canceled(indexPath: NSIndexPath) {
    var constrainedView = cells[indexPath.row]
    if (constrainedView.state == CellState.Expanded) {
      scrollToRowAtIndexPath(indexPath, onlyWhenNegative: true)
      constrainedView.state = .Collapsed
      constrainedView.updateViews([
        "preview": UIView(),
      ])
      updateSingleRow(indexPath)
    }
  }
}