//
//  mainViewController.m
//  2048
//
//  Created by quentin PIDOUX on 26/01/2015.
//  Copyright (c) 2015 Connectiv'IT. All rights reserved.
//

#import "mainViewController.h"

@interface mainViewController () {
    NSInteger pills[4][4];
}

@end

@implementation mainViewController

- (id)initWithCoder:(NSCoder *)aDecoder {

    self = [super initWithCoder:aDecoder];
    if (self) {
        pills[0][0] = 1;
        pills[1][0] = 2;
        pills[2][0] = 3;
        pills[3][0] = 4;
        pills[0][1] = 5;
        pills[1][1] = 6;
        pills[2][1] = 7;
        pills[3][1] = 8;
        pills[0][2] = 9;
        pills[1][2] = 10;
        pills[2][2] = 11;
        pills[3][2] = 12;
        pills[0][3] = 13;
        pills[1][3] = 14;
        pills[2][3] = 15;
        pills[3][3] = 16;
    }

    return self;
}

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    return UIEdgeInsetsZero;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _board = [[game alloc] init];
    _boardEnabled = YES;
    
    [_playAgainButton setTitle:NSLocalizedString(@"NEW_GAME", nil) forState:UIControlStateNormal];

    self.scoreLabel.hidden = false;
    self.scoreLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Score: %li", nil), (long)self.board.score];

    if ([[NSUserDefaults standardUserDefaults] integerForKey: @"highScore"] > 0) {
        self.highScoreLabel.hidden = false;
        self.highScoreLabel.text = [NSString stringWithFormat:NSLocalizedString(@"HIGHSCORE %li", nil), (long)[[NSUserDefaults standardUserDefaults] integerForKey: @"highScore"]];
    }
}

- (void)updatePillsWithTransition :(UIViewAnimationOptions)transition {
    for (NSInteger x = 0; x < 4; x++) {
        for (NSInteger y = 0; y < 4; y++) {
            gamePill *piece = (gamePill *)[self.view viewWithTag:pills[x][y]];
            [UIView transitionWithView:piece
                              duration:0.2
                               options:transition
                            animations:^{
                                piece.status = [self.board getPillAtCoordX:x Y:y];
                            }completion:nil];
        }
    }

    [self printScore];
}

- (void) printScore {
    if ((long)self.board.score > [[NSUserDefaults standardUserDefaults] integerForKey: @"highScore"]) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:self.board.score] forKey:@"highScore"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        self.highScoreLabel.hidden = false;

        self.highScoreLabel.text = [NSString stringWithFormat:NSLocalizedString(@"HIGHSCORE %li", nil), (long)[[NSUserDefaults standardUserDefaults] integerForKey: @"highScore"]];
    }

    _scoreLabel.text = [NSString stringWithFormat:NSLocalizedString(@"SCORE %li", nil), (long)self.board.score];

    if (self.board.endOfGame) {
        [self disableBoard];
        if (self.board.loose == true)
            self.scoreLabel.text = NSLocalizedString(@"YOU_LOSE", nil);

        else
            self.scoreLabel.text = NSLocalizedString(@"YOU_WON", nil);
    }
}

#pragma mark - Board enable/disable

- (void)enableBoard {

    if (!self.boardEnabled) {
        for (NSInteger x = 0; x < 4; x++) {
            for (NSInteger y = 0; y < 4; y++) {
                gamePill *piece = (gamePill *)[self.view viewWithTag:pills[x][y]];
                [UIView animateWithDuration:1.0
                                 animations:^{
                                     piece.alpha = 1.0;
                                 }];
            }
        }
        _boardEnabled = YES;
    }
}

- (void)disableBoard {
    if (self.boardEnabled) {
        _boardEnabled = NO;
        [self printScore];
        for (NSInteger x = 0; x < 4; x++) {
            for (NSInteger y = 0; y < 4; y++) {
                gamePill *piece = (gamePill *)[self.view viewWithTag:pills[x][y]];
                [UIView animateWithDuration:1.0
                                 animations:^{
                                     piece.alpha = 0.2;
                                 }];
            }
        }
    }
}

#pragma mark - Mouvements

- (IBAction)userSwipeLeft:(id)sender {

    if ([self.board slideLeft] &&
        self.boardEnabled) {

        [self.board randomize];
        [self updatePillsWithTransition :UIViewAnimationOptionTransitionFlipFromRight];
    }
}

- (IBAction)userSwipeRight:(id)sender {

    if ([self.board slideRight] &&
        self.boardEnabled) {

        [self.board randomize];
        [self updatePillsWithTransition :UIViewAnimationOptionTransitionFlipFromLeft];
    }
}

- (IBAction)userSwipeUp:(id)sender {

    if ([self.board slideUp] &&
        self.boardEnabled) {

        [self.board randomize];
        [self updatePillsWithTransition :UIViewAnimationOptionTransitionFlipFromTop];
    }
}

- (IBAction)userSwipeDown:(id)sender {

    if ([self.board slideDown] &&
        self.boardEnabled) {

        [self.board randomize];
        [self updatePillsWithTransition :UIViewAnimationOptionTransitionFlipFromBottom];
    }
}

- (IBAction)userNewGame:(id)sender {

    [self enableBoard];
    [[NSUbiquitousKeyValueStore defaultStore] synchronize];
    self.board = [[game alloc] init];
    [self updatePillsWithTransition :UIViewAnimationOptionTransitionCrossDissolve];
}


#pragma mark - Highscore save and load

- (void)loadLeaderboardInfo {

    [GKLeaderboard loadLeaderboardsWithCompletionHandler:^(NSArray *leaderboards, NSError *error) {
        if (!error)
            self.leaderboards = leaderboards;
    }];
}

- (GKLeaderboard *)leaderboardForIdentifier:(NSString *)identifier {

    for (GKLeaderboard *leaderboard in self.leaderboards)
        if ([leaderboard.identifier isEqualToString:identifier])
            return leaderboard;

    return nil;
}

- (void)reportScore:(int64_t)score forLeaderboardID:(NSString *)identifier {

    GKScore *scoreReporter = [[GKScore alloc] initWithLeaderboardIdentifier:identifier];
    scoreReporter.value = score;
    [GKScore reportScores:@[scoreReporter]
    withCompletionHandler:^(NSError *error) {
        if (!error) {
        }
        else {
            NSLog(@"Error: %@", error);
        }
    }];
}

@end
