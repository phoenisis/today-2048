//
//  gamePill.m
//  2048
//
//  Created by quentin PIDOUX on 26/01/2015.
//  Copyright (c) 2015 Connectiv'IT. All rights reserved.
//

#import "gamePill.h"

@implementation gamePill

- (void)setStatus:(ePills)status {
    _status = status;
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
        self.status = pillEmpty;

    return self;
}

- (void)drawRect:(CGRect)rect {

    CGRect pillRectEmptyTo64    = CGRectMake(0, 0, 50, 50);
    CGRect pillRect128to2048    = CGRectMake(0, 10, 50, 50);

    NSMutableParagraphStyle* textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    [textStyle setAlignment: NSTextAlignmentCenter];

    NSDictionary* textFontEmptyTo64 = @{NSFontAttributeName: [UIFont fontWithName: @"AvenirNext-Regular" size: 40], NSForegroundColorAttributeName: [UIColor whiteColor], NSParagraphStyleAttributeName: textStyle};
    NSDictionary* textFont128to512  = @{NSFontAttributeName: [UIFont fontWithName: @"AvenirNext-Regular" size: 25], NSForegroundColorAttributeName: [UIColor whiteColor], NSParagraphStyleAttributeName: textStyle};
    NSDictionary* textFont1024to248 = @{NSFontAttributeName: [UIFont fontWithName: @"AvenirNext-Regular" size: 20], NSForegroundColorAttributeName: [UIColor whiteColor], NSParagraphStyleAttributeName: textStyle};

    UIColor* colorEmpty = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0.5];
    UIColor *color2     = [UIColor colorWithRed:248/255.0f green:87/255.0f blue:89/255.0f alpha:1.0f];
    UIColor *color4     = [UIColor colorWithRed:255/255.0f green:115/255.0f blue:42/255.0f alpha:1.0f];
    UIColor *color8     = [UIColor colorWithRed:255/255.0f green:219/255.0f blue:0/255.0f alpha:1.0f];
    UIColor *color16    = [UIColor colorWithRed:142/255.0f green:209/255.0f blue:181/255.0f alpha:1.0f];
    UIColor *color32    = [UIColor colorWithRed:29/255.0f green:139/255.0f blue:113/255.0f alpha:1.0f];
    UIColor * color64   = [UIColor colorWithRed:120/255.0f green:181/255.0f blue:224/255.0f alpha:1.0f];
    UIColor * color128  = [UIColor colorWithRed:0/255.0f green:102/255.0f blue:186/255.0f alpha:1.0f];
    UIColor * color256  = [UIColor colorWithRed:162/255.0f green:138/255.0f blue:202/255.0f alpha:1.0f];
    UIColor * color512  = [UIColor colorWithRed:131/255.0f green:122/255.0f blue:170/255.0f alpha:1.0f];
    UIColor * color1024 = [UIColor colorWithRed:193/255.0f green:82/255.0f blue:162/255.0f alpha:1.0f];
    UIColor * color2048 = [UIColor colorWithRed:130/255.0f green:10/255.0f blue:99/255.0f alpha:1.0f];

    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: pillRectEmptyTo64];

    
    if (self.status == pill2) {
        NSString* textContent = @"2";

        [color2 setFill];
        [rectanglePath fill];
        
        [textContent drawInRect: pillRectEmptyTo64 withAttributes: textFontEmptyTo64];
    }

    else if (self.status == pill4) {
        NSString* testContent = @"4";

        [color4 setFill];
        [rectanglePath fill];

        [testContent drawInRect: pillRectEmptyTo64 withAttributes: textFontEmptyTo64];
    }

    else if (self.status == pill8) {
        NSString* testContent = @"8";

        [color8 setFill];
        [rectanglePath fill];
        
        [testContent drawInRect: pillRectEmptyTo64 withAttributes: textFontEmptyTo64];
    }

    else if (self.status == pill16) {
        NSString* testContent = @"16";

        [color16 setFill];
        [rectanglePath fill];

        [testContent drawInRect: pillRectEmptyTo64 withAttributes: textFontEmptyTo64];
    }

    else if (self.status == pill32) {
        NSString* testContent = @"32";

        [color32 setFill];
        [rectanglePath fill];

        [testContent drawInRect: pillRectEmptyTo64 withAttributes: textFontEmptyTo64];
    }

    else if (self.status == pill64) {
        NSString* testContent = @"64";

        [color64 setFill];
        [rectanglePath fill];

        [testContent drawInRect: pillRectEmptyTo64 withAttributes: textFontEmptyTo64];
    }

    else if (self.status == pill128) {
        NSString* testContent = @"128";

        [color128 setFill];
        [rectanglePath fill];

        [testContent drawInRect: pillRect128to2048 withAttributes: textFont128to512];
    }

    else if (self.status == pill256) {
        NSString* testContent = @"256";

        [color256 setFill];
        [rectanglePath fill];

        [testContent drawInRect: pillRect128to2048 withAttributes: textFont128to512];
    }

    else if (self.status == pill512) {
        NSString* testContent = @"512";

        [color512 setFill];
        [rectanglePath fill];

        [testContent drawInRect: pillRect128to2048 withAttributes: textFont128to512];
    }

    else if (self.status == pill1024) {
        NSString* testContent = @"1024";

        [color1024 setFill];
        [rectanglePath fill];

        [testContent drawInRect: pillRect128to2048 withAttributes: textFont1024to248];
    }

    else if (self.status == pill2048) {
        NSString* testContent = @"2048";

        [color2048 setFill];
        [rectanglePath fill];

        [testContent drawInRect: pillRect128to2048 withAttributes: textFont1024to248];
    }

    else {
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: pillRectEmptyTo64];
        [colorEmpty setFill];
        [rectanglePath fill];
    }
}


@end
