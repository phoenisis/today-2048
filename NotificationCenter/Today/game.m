//
//  game.m
//  2048
//
//  Created by quentin PIDOUX on 26/01/2015.
//  Copyright (c) 2015 Connectiv'IT. All rights reserved.
//

#import "game.h"

@implementation game {
    ePills board[4][4];
    BOOL canAdd[4][4];
}

+ (game *)boardWithBoard:(game *)data {
    
    return [[game alloc] initWithBoard:data];
}

- (id)init {
    
    if (self = [super init]) {
        _loose = NO;
        for (NSInteger  x = 0; x < 4; x++)
            for (NSInteger y = 0; y < 4; y++)
                board[x][y] = pillEmpty;
        
        for (NSInteger x = 0; x < 4; x++)
            for (NSInteger y = 0; y < 4; y++)
                canAdd[x][y] = YES;
    }
    
    NSInteger x1 = arc4random() % 4;
    NSInteger y1 = arc4random() % 4;
    NSInteger x2 = arc4random() % 4;
    NSInteger y2 = arc4random() % 4;
    
    while (x1 == x2 &&
           y1 == y2) {
        x2 = arc4random() % 4;
        y2 = arc4random() % 3;
    }
    
    board[x1][y1] = pill2;
    board[x2][y2] = pill2;
    
    return self;
}

- (BOOL)isEqual:(id)object {
    
    game *obj = (game *)object;
    for (NSInteger x = 0; x < 4; x++)
        for (NSInteger y = 0; y < 4; y++)
            if (board[x][y] != obj->board[x][y])
                return FALSE;

    return YES;
}

#pragma mark - ckeck and move

- (BOOL)endOfGame {
    
    for (NSInteger x = 0; x < 4; x++)
        for (NSInteger y = 0; y < 4; y++)
            if (board[x][y] == pill2048)
                return YES;
    
    for (NSInteger x = 0; x < 4; x++)
        for (NSInteger y = 0; y < 4; y++)
            if (board[x][y] == pillEmpty)
                return FALSE;
    
    for (NSInteger x = 0; x < 4; x++) {
        for (NSInteger y = 0; y < 4; y++) {
            ePills type = board[x][y];
            
            for (NSInteger i = x-1; i <= x+1 ; i+=2)
                if ([self checkCoordforX:i Y:y])
                    if (board[i][y] == type)
                        return FALSE;
                    
            for (NSInteger j = y-1; j <= y+1; j+=2)
                if ([self checkCoordforX:x Y:j])
                    if (board[x][j] == type)
                        return FALSE;
        }
    }
    
    _loose = YES;
    return YES;
}

#pragma mark - Private Instance Methods

- (BOOL)checkCoordforX:(NSInteger)x Y:(NSInteger)y {
    
    if (x >= 0 && x < 4 &&
        y >= 0 && y < 4)
        return true;

    return false;
}

- (void)moveUpX:(NSInteger)x Y:(NSInteger)y {
    
    if (y == 0)
        return;

    else if (board[x][y] == pillEmpty)
        return;


    else if (board[x][y-1] == board[x][y] &&
             canAdd[x][y-1]) {
        board[x][y-1] = (ePills)(board[x][y] + board[x][y-1]);
        board[x][y] = pillEmpty;
        _score = _score + (NSInteger)(board[x][y-1]);
        canAdd[x][y-1] = NO;
        
        return;
    }

    else if (board[x][y-1] == pillEmpty) {
        board[x][y-1] = board[x][y];
        board[x][y] = pillEmpty;
        [self moveUpX:x Y:y-1];
    }

    else
        return;
}

- (void)moveDownX:(NSInteger)x Y:(NSInteger)y {
    
    if (y == 3)
        return;

    else if (board[x][y] == pillEmpty)
        return;

    else if (board[x][y+1] == board[x][y] &&
             canAdd[x][y+1]) {

        board[x][y+1] = (ePills)(board[x][y] + board[x][y+1]);
        board[x][y] = pillEmpty;
        _score = _score + (NSInteger)(board[x][y+1]);
        canAdd[x][y+1] = NO;
        
        return;
    }

    else if (board[x][y+1] == pillEmpty) {
        board[x][y+1] = board[x][y];
        board[x][y] = pillEmpty;
        [self moveDownX:x Y:y+1];
    }

    else
        return;
}

- (void)moveRightX:(NSInteger)x Y:(NSInteger)y {

    if (x == 3)
        return;

    else if (board[x][y] == pillEmpty)
        return;

    else if (board[x+1][y] == board[x][y] &&
             canAdd[x+1][y]) {
        board[x+1][y] = (ePills)(board[x][y] + board[x+1][y]);
        board[x][y] = pillEmpty;
        _score = _score + (NSInteger)(board[x+1][y]);
        canAdd[x+1][y] = NO;
        
        return;
    }

    else if (board[x+1][y] == pillEmpty) {
        board[x+1][y] = board[x][y];
        board[x][y] = pillEmpty;
        [self moveRightX:x+1 Y:y];
    }

    else
        return;
}

- (void)moveLeftX:(NSInteger)x Y:(NSInteger)y {
    
    if (x == 0)
        return;

    else if (board[x][y] == pillEmpty)
        return;

    else if (board[x-1][y] == board[x][y] &&
             canAdd[x-1][y]) {
        board[x-1][y] = (ePills)(board[x][y] + board[x-1][y]);
        board[x][y] = pillEmpty;
        _score = _score + (NSInteger)(board[x-1][y]);
        canAdd[x-1][y] = NO;
        return;
    }

    else if (board[x-1][y] == pillEmpty) {
        board[x-1][y] = board[x][y];
        board[x][y] = pillEmpty;
        [self moveLeftX:x-1 Y:y];
    }

    else
        return;
}

- (void)resetCanAdd {
 
    for (NSInteger x = 0; x < 4; x++)
        for (NSInteger y = 0; y < 4; y++)
            canAdd[x][y] = YES;
}

#pragma mark - Public Instance Methods

- (id)initWithBoard:(game *)data {
    
    if (self = [super init])
        for (NSInteger x = 0; x < 4; x++)
            for (NSInteger y = 0; y < 4; y++)
                board[x][y] = data->board[x][y];
    
    return self;
}

- (void)randomize {
    
    NSInteger empty[16];
    NSInteger numEmpty = 0;
    
    for (NSInteger i = 0; i < 16; i++) {
        if (board[i%4][i/4] == pillEmpty) {
            empty[numEmpty] = i;
            numEmpty++;
        }
    }
    
    if (numEmpty > 0) {
        NSInteger coords = empty[arc4random() % numEmpty];
        
        ePills pieceToDrop;
        NSInteger piece = arc4random() % 2;
        
        if (piece == 0)
            pieceToDrop = pill2;

        else
            pieceToDrop = pill4;
        
        board[coords%4][coords/4] = pieceToDrop;
    }
}

- (BOOL)slideUp {
    
    ePills copy[4][4];
    for (NSInteger x = 0; x < 4; x++)
        for (NSInteger y = 0; y < 4; y++)
            copy[x][y] = board[x][y];
    
    for (NSInteger x = 0; x < 4; x++)
        for (NSInteger y = 0; y < 4; y++)
            [self moveUpX:x Y:y];
    
    [self resetCanAdd];
    
    for (NSInteger x = 0; x < 4; x++)
        for (NSInteger y = 0; y < 4; y++)
            if (copy[x][y] != board[x][y])
                return YES;
    
    return NO;
}

- (BOOL)slideDown {
    
    ePills copy[4][4];
    for (NSInteger x = 0; x < 4; x++)
        for (NSInteger y = 0; y < 4; y++)
            copy[x][y] = board[x][y];
    
    for (NSInteger x = 0; x < 4; x++)
        for (NSInteger y = 3; y >= 0; y--)
            [self moveDownX:x Y:y];
    
    [self resetCanAdd];
    
    for (NSInteger x = 0; x < 4; x++)
        for (NSInteger y = 0; y < 4; y++)
            if (copy[x][y] != board[x][y])
                return YES;

    return NO;
}

- (BOOL)slideLeft {
    
    ePills copy[4][4];
    for (NSInteger x = 0; x < 4; x++)
        for (NSInteger y = 0; y < 4; y++)
            copy[x][y] = board[x][y];
    
    for (NSInteger x = 0; x < 4; x++)
        for (NSInteger y = 0; y < 4; y++)
            [self moveLeftX:x Y:y];

    [self resetCanAdd];
    
    for (NSInteger x = 0; x < 4; x++)
        for (NSInteger y = 0; y < 4; y++)
            if (copy[x][y] != board[x][y])
                return YES;

    return NO;
}

- (BOOL)slideRight {
    
    ePills copy[4][4];
    for (NSInteger x = 0; x < 4; x++)
        for (NSInteger y = 0; y < 4; y++)
            copy[x][y] = board[x][y];

    for (NSInteger y = 0; y < 4; y++)
        for (NSInteger x = 3; x >= 0; x--)
            [self moveRightX:x Y:y];
    
    [self resetCanAdd];
    
    for (NSInteger y = 0; y < 4; y++)
        for (NSInteger x = 0; x < 4; x++)
            if (copy[x][y] != board[x][y])
                return YES;

    return NO;
}

- (ePills)getPillAtCoordX:(NSInteger)x Y:(NSInteger)y {
    
    return board[x][y];
}

@end
