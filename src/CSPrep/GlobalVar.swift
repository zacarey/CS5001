//
//  LabelColor.swift
//  Algorithms
//
//  Created by Loc Tran on 3/22/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit

let DEFAULT_COLOR = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
let COMPARE_COLOR = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha: 1)
let SWAP_COLOR = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
let KEY_COLOR = UIColor(red: 51/255, green: 255/255, blue: 51/255, alpha: 1)
let SORT_END = UIColor(red: 0/255, green: 255/255, blue: 51/255, alpha: 1)

let DEFAULT_ALPHA: CGFloat = 1
let ANIMATION_ALPHA: CGFloat = 0.5

var PADDING: CGFloat = 10
var SPACING: CGFloat = 0
var DISTANCEROW: CGFloat = 0

let GRAY_COLOR = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
let GOLD_COLOR = UIColor(red: 1, green: 215/255, blue: 0, alpha: 1)
let GREEN_COLOR = UIColor(red: 0, green: 1, blue: 0, alpha: 0.4)

//let LIME_COLOR = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha: 1)
let LIME_COLOR = UIColor(red: 100/255, green: 177/255, blue: 241/255, alpha: 1)

let DARK_ORCHID = UIColor(red: 153/255, green: 50/255, blue: 204/255, alpha: 0.7)
let SLATEGRAY_COLOR = UIColor(red: 112/255, green: 128/255, blue: 144/255, alpha: 1)

var RECTSIZE: CGFloat = 0

var yMax: CGFloat = 0

var btnSizeBoardTmp: UIButton!
var textInPutBoard: UITextField!
var btnStepTmp: UIButton!
var btnBackTmp: UIButton!
var btnRunTmp: UIButton!
var arrayViewTmp: UILabel!
var btnStepBigTmp: UIButton!
var labelPushTmp: UILabel!
var labelPopTmp: UILabel!
var labelTopTmp: UILabel!
var lblNoteStartTmp: UILabel!
var labelEnqueuesTmp: SortingLabel!
var labelDequeuesTmp: SortingLabel!
var labelRearTmp: SortingLabel!
var labelFrontTmp: SortingLabel!

var DISPLAY_FONT_MIN: CGFloat = 10
var DISPLAY_FONT_MAX: CGFloat = 60

let BUTTON_COLOR = UIColor.white

var DETAIL: UIViewController!
var ROW_MENU_SECTION: Int!
var ROW_MENU_CELL: Int!
var INPUT_XIB_CLASS: UIViewController!
var VIEW_CHOSEN: String!
var PDF_TITLE: String!

var btnStartTmp:UIButton!
var btnNextTmp:UIButton!
var btnPauseActionTmp: UIButton!
var btnResetTmp:UIButton!

var Spacing_Center:CGFloat!
var yEnd_Tower: CGFloat!

var xEndMove_Stacks: CGFloat!
var yEndMove_Stacks: CGFloat!
var y_Queues: CGFloat!
var y_nav: CGFloat!

