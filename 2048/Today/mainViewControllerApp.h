//
//  mainViewControllerApp.h
//  2048
//
//  Created by quentin PIDOUX on 26/01/2015.
//  Copyright (c) 2015 Connectiv'IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import <NotificationCenter/NotificationCenter.h>

#import "gameApp.h"
#import "gamePillApp.h"

@interface mainViewControllerApp : UIViewController <GKGameCenterControllerDelegate>

@property (nonatomic, strong) game *board;
@property (nonatomic, assign, readonly, getter = isBoardEnabled) BOOL boardEnabled;

@property (nonatomic, strong) NSArray *leaderboards;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *highScoreNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *playAgainButton;

- (void)enableBoard;
- (void)disableBoard;


- (IBAction)userSwipeLeft:(id)sender;
- (IBAction)userSwipeRight:(id)sender;
- (IBAction)userSwipeUp:(id)sender;
- (IBAction)userSwipeDown:(id)sender;

@end
