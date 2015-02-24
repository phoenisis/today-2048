//
//  mainViewController.m
//  2048
//
//  Created by quentin PIDOUX on 26/01/2015.
//  Copyright (c) 2015 Connectiv'IT. All rights reserved.
//

#import "mainViewControllerApp.h"

@interface mainViewControllerApp () {
    NSInteger pills[4][4];
}
@end

@implementation mainViewControllerApp

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
    _highScoreLabel.text = NSLocalizedString(@"HIGHSCORE", nil);
    _scoreLabel.text = NSLocalizedString(@"Score", nil);

    if ([[NSUserDefaults standardUserDefaults] integerForKey: @"highScore"] > 0) {

        self.highScoreLabel.hidden = false;
        self.highScoreNumberLabel.text = [NSString stringWithFormat:@"%ld", [[NSUserDefaults standardUserDefaults] integerForKey: @"highScore"]];
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

    self.scoreLabel.hidden = false;
    _scoreNumberLabel.text = [NSString stringWithFormat:@"%li", (long)self.board.score];

    if ((long)self.board.score > [[NSUserDefaults standardUserDefaults] integerForKey: @"highScore"]) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:self.board.score] forKey:@"highScore"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        self.highScoreNumberLabel.text = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults] integerForKey: @"highScore"]];
    }

    if (self.board.over) {
        [self disableBoard];
        if (self.board.loose)
            self.scoreNumberLabel.text = NSLocalizedString(@"You lose !", nil);

        else
            self.scoreNumberLabel.text = NSLocalizedString(@"You won !", nil);
    }
}


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
            NSLog(@"Enregistrement du score %lli dans le tableau des scores avec l'ID %@", score, identifier);
        }
        else {
            NSLog(@"Echec de l'enregistrement des score avec l'erreur: %@", error);
        }
    }];
}

#pragma mark - Board enable/disable

- (void)enableBoard {

    if (!self.isBoardEnabled) {
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
    if (self.isBoardEnabled) {
        _boardEnabled = NO;
        _scoreNumberLabel.text = [NSString stringWithFormat:@"%li", (long)self.board.score];

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
        self.isBoardEnabled) {

        [self.board randomize];
        [self updatePillsWithTransition :UIViewAnimationOptionTransitionFlipFromRight];
    }
}

- (IBAction)userSwipeRight:(id)sender {

    if ([self.board slideRight] &&
        self.isBoardEnabled) {

        [self.board randomize];
        [self updatePillsWithTransition :UIViewAnimationOptionTransitionFlipFromLeft];
    }
}

- (IBAction)userSwipeUp:(id)sender {

    if ([self.board slideUp] &&
        self.isBoardEnabled) {

        [self.board randomize];
        [self updatePillsWithTransition :UIViewAnimationOptionTransitionFlipFromTop];
    }
}

- (IBAction)userSwipeDown:(id)sender {

    if ([self.board slideDown] &&
        self.isBoardEnabled) {

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

@end
