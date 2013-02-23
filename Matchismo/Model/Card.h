//
//  Card.h
//  Matchismo
//
//  Created by Joey Smith on 1/28/13.
//  Copyright (c) 2013 Joey Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isFaceUp) BOOL faceUp;
@property (nonatomic, getter=isUnplayable) BOOL unPlayable;

- (int)match:(NSArray *)otherCards;
- (int)match:(NSMutableArray *)otherCards matchLevel:(NSUInteger)matchLevel;
@end
