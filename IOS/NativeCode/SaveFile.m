
#import "SaveFile.h"
#import "Constants.h"

@interface SaveFile (Private)

- (void)fillNewValues;

@end

@implementation SaveFile

static SaveFile* saveFile = nil;
@synthesize totalTimePlayed;
@synthesize totalCakes;
@synthesize totalCoins;
@synthesize remainingCakes;
@synthesize remainingCoins;
@synthesize spentCakes;
@synthesize spentCoins;
@synthesize highestCombo;
@synthesize listCostumes;
@synthesize listStages;
@synthesize listCharacters;

+(SaveFile*)sharedFile
{
	
	if (saveFile == nil)
		saveFile = [[[self class] alloc] init];
    
	return saveFile;
}

- (id) init
{
	
	self = [super init];
	if (self != nil)
	{
        self.totalTimePlayed = 0;
        self.totalCakes = 0;
        self.totalCoins = 0;
        self.remainingCakes = 0;
        self.remainingCoins = 0;
        self.spentCakes = 0;
        self.spentCoins = 0;
        self.highestCombo = 0;
        
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentDirectory = [paths objectAtIndex:0];
		NSString *filePath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sav",RWappName]];
		if(![[NSFileManager defaultManager] fileExistsAtPath:filePath]){
            self.listStages = [[NSMutableDictionary alloc] init];
            self.listCostumes = [[NSMutableDictionary alloc] init];
            self.listCharacters = [[NSMutableDictionary alloc] init];
		}		
	}
    
    [self fillNewValues];
    
	return self;
	
}

+(void) loadData
{
    @synchronized([SaveFile class]) {
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentDirectory = [paths objectAtIndex:0];
		NSString *filePath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sav",RWappName]];
        saveFile = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
		
    }
}

+(void) saveData
{
	[[NSUserDefaults standardUserDefaults] synchronize];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDirectory = [paths objectAtIndex:0];
	NSString *filePath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sav",RWappName]];
	[NSKeyedArchiver archiveRootObject:saveFile toFile:filePath];
}

-(void) encodeWithCoder:(NSCoder*)coder
{
    [coder encodeFloat:totalTimePlayed forKey:@"totalTimePlayed"];
    [coder encodeInt:totalCakes forKey:@"totalCakes"];
    [coder encodeInt:totalCoins forKey:@"totalCoins"];
    [coder encodeInt:remainingCakes forKey:@"remainingCakes"];
    [coder encodeInt:remainingCoins forKey:@"remainingCoins"];
    [coder encodeInt:spentCakes forKey:@"spentCakes"];
    [coder encodeInt:spentCoins forKey:@"spentCoins"];
    [coder encodeInt:highestCombo forKey:@"highestCombo"];
    [coder encodeObject:listCharacters forKey:@"listCharacters"];
    [coder encodeObject:listCostumes forKey:@"listCostumes"];
    [coder encodeObject:listStages forKey:@"listStages"];
}

-(id) initWithCoder:(NSCoder*)coder
{
	self = [super init];
	
    totalTimePlayed = [coder decodeFloatForKey:@"totalTimePlayed"];
    totalCakes = [coder decodeIntForKey:@"totalCakes"];
    totalCoins = [coder decodeIntForKey:@"totalCoins"];
    remainingCakes = [coder decodeIntForKey:@"remainingCakes"];
    remainingCoins = [coder decodeIntForKey:@"remainingCoins"];
    spentCakes = [coder decodeIntForKey:@"spentCakes"];
    spentCoins = [coder decodeIntForKey:@"spentCoins"];
    highestCombo = [coder decodeIntForKey:@"highestCombo"];
    listCostumes = [coder decodeObjectForKey:@"listCostumes"];
    listStages = [coder decodeObjectForKey:@"listStages"];
    listCharacters = [coder decodeObjectForKey:@"listCharacters"];
    
    
    [self fillNewValues];
    
	return self;
	
}

- (void)fillNewValues
{
    if (self.listCostumes == nil)
        self.listCostumes = [[NSMutableDictionary alloc]init];
    if (self.listStages == nil)
        self.listStages = [[NSMutableDictionary alloc]init];
    if (self.listCharacters == nil)
        self.listCharacters = [[NSMutableDictionary alloc] init];

}

@end
