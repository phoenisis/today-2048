//
//  game.h
//  2048
//
//  Created by quentin PIDOUX on 26/01/2015.
//  Copyright (c) 2015 Connectiv'IT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface game : NSObject

typedef enum {
    pillEmpty   = 0,
    pill2       = 2,
    pill4       = 4,
    pill8       = 8,
    pill16      = 16,
    pill32      = 32,
    pill64      = 64,
    pill128     = 128,
    pill256     = 256,
    pill512     = 512,
    pill1024    = 1024,
    pill2048    = 2048
    
} ePills;

@property (nonatomic, assign, readonly) NSInteger score;
@property (nonatomic, readonly, getter = endOfGame) BOOL over;
@property (nonatomic, readonly) BOOL loose;

+ (game *)boardWithBoard:(game *)data;

- (id)initWithBoard:(game *)data;
- (BOOL)slideRight;
- (BOOL)slideLeft;
- (BOOL)slideUp;
- (BOOL)slideDown;
- (void)randomize;

- (ePills)getPillAtCoordX:(NSInteger)x Y:(NSInteger)y;

@end
