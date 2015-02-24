//
//  mainViewController.h
//  2048
//
//  Created by quentin PIDOUX on 26/01/2015.
//  Copyright (c) 2015 Connectiv'IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import <NotificationCenter/NotificationCenter.h>

#import "game.h"
#import "gamePill.h"

@interface mainViewController : UIViewController

@property (nonatomic, strong) game *board;
@property (nonatomic, assign) BOOL boardEnabled;

@property (nonatomic, strong) NSArray *leaderboards;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *playAgainButton;

- (void)enableBoard;
- (void)disableBoard;

@end
