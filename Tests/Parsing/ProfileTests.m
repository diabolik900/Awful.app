//
//  ProfileTests.m
//  Awful
//
//  Created by Nolan Waite on 2012-10-10.
//  Copyright (c) 2012 Regular Berry Software LLC. All rights reserved.
//

#import "ParsingTests.h"

@interface EditProfileTests : ParsingTests @end
@implementation EditProfileTests

+ (NSString *)fixtureFilename { return @"member.html"; }

- (void)testEditProfileInfo
{
    ProfileParsedInfo *profileInfo = [[ProfileParsedInfo alloc] initWithHTMLData:self.fixture];
    STAssertEqualObjects(profileInfo.userID, @"106125", nil);
    STAssertEqualObjects(profileInfo.username, @"pokeyman", nil);
}

@end


#define STAssertStringContainsSubstringOnce(s, sub, ...) do { \
    NSRange __a = [s rangeOfString:sub]; \
    STAssertTrue(__a.location != NSNotFound, __VA_ARGS__); \
    NSRange __b = [s rangeOfString:sub options:NSBackwardsSearch]; \
    STAssertTrue(NSEqualRanges(__a, __b), __VA_ARGS__); \
} while (0)


#define STAssertStringDoesNotContain(s, sub, ...) \
    STAssertTrue([s rangeOfString:sub].location == NSNotFound, __VA_ARGS__)


@interface ViewProfileWithAvatarAndTextTests : ParsingTests @end
@implementation ViewProfileWithAvatarAndTextTests

+ (NSString *)fixtureFilename { return @"profile.html"; }

- (void)testViewAvatarAndText
{
    ProfileParsedInfo *profile = [[ProfileParsedInfo alloc] initWithHTMLData:self.fixture];
    STAssertEqualObjects(profile.username, @"pokeyman", nil);
    STAssertNotNil(profile.avatar, nil);
    STAssertStringContainsSubstringOnce(profile.customTitle, @"play?", nil);
    STAssertStringDoesNotContain(profile.customTitle, @"title-pokeyman", nil);
    STAssertEqualObjects(profile.icqName, @"1234", nil);
    STAssertNil(profile.aimName, nil);
    STAssertEquals(profile.postCount, 1954, nil);
    STAssertTrue([profile.postRate rangeOfString:@"0.88"].location == 0, nil);
    STAssertEqualObjects(profile.gender, @"porpoise", nil);
}

@end


@interface ViewProfileWithAvatarAndGangTagTests : ParsingTests @end
@implementation ViewProfileWithAvatarAndGangTagTests

+ (NSString *)fixtureFilename { return @"profile2.html"; }

- (void)testViewAvatarAndGangTag
{
    ProfileParsedInfo *profile = [[ProfileParsedInfo alloc] initWithHTMLData:self.fixture];
    STAssertEqualObjects(profile.username, @"Ronald Raiden", nil);
    STAssertEqualObjects(profile.location, @"San Francisco", nil);
    STAssertStringContainsSubstringOnce([profile.avatar absoluteString], @"safs/titles", nil);
    STAssertStringContainsSubstringOnce(profile.customTitle, @"dd/68", nil);
    STAssertStringDoesNotContain(profile.customTitle, @"01/df", nil);
}

@end


@interface ViewProfileWithAvatarAndFunkyTextTests : ParsingTests @end
@implementation ViewProfileWithAvatarAndFunkyTextTests

+ (NSString *)fixtureFilename { return @"profile3.html"; }

- (void)testViewAvatarAndFunkyText
{
    ProfileParsedInfo *profile = [[ProfileParsedInfo alloc] initWithHTMLData:self.fixture];
    STAssertEqualObjects(profile.username, @"Rinkles", nil);
    STAssertStringContainsSubstringOnce(profile.customTitle, @"<i>", nil);
    STAssertStringContainsSubstringOnce(profile.customTitle, @"I'm getting at is", nil);
    STAssertStringDoesNotContain(profile.customTitle, @"safs/titles", nil);
}

@end

@interface ViewProfileWithNoAvatarOrTitleTests : ParsingTests @end
@implementation ViewProfileWithNoAvatarOrTitleTests

+ (NSString *)fixtureFilename { return @"profile4.html"; }

- (void)testViewNoAvatarOrTitle
{
    ProfileParsedInfo *profile = [[ProfileParsedInfo alloc] initWithHTMLData:self.fixture];
    STAssertEqualObjects(profile.username, @"Cryptic Edge", nil);
    STAssertNil(profile.avatar, nil);
}

@end


@interface ViewStupidNewbieProfileTests : ParsingTests @end
@implementation ViewStupidNewbieProfileTests

+ (NSString *)fixtureFilename { return @"profile5.html"; }

- (void)testViewStupidNewbie
{
    ProfileParsedInfo *profile = [[ProfileParsedInfo alloc] initWithHTMLData:self.fixture];
    STAssertEqualObjects(profile.username, @"Grim Up North", nil);
    STAssertStringContainsSubstringOnce([profile.avatar absoluteString], @"newbie.gif", nil);
    STAssertStringDoesNotContain(profile.customTitle, @"newbie.gif", nil);
}

@end


@interface ViewProfileWithTitleAndGangTagAndNoAvatar : ParsingTests @end
@implementation ViewProfileWithTitleAndGangTagAndNoAvatar

+ (NSString *)fixtureFilename { return @"profile6.html"; }

- (void)testViewTitleAndGangTagAndNoAvatar
{
    ProfileParsedInfo *profile = [[ProfileParsedInfo alloc] initWithHTMLData:self.fixture];
    STAssertEqualObjects(profile.username, @"The Gripper", nil);
    STAssertNil(profile.avatar, nil);
    STAssertStringContainsSubstringOnce(profile.customTitle, @"i am winner", nil);
    STAssertStringContainsSubstringOnce(profile.customTitle, @"tccburnouts.png", nil);
}

@end
