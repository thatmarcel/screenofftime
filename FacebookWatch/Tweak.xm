@interface FBStreamListCollectionView: UICollectionView
    - (id) dataSource; // FBComponentCollectionViewDataSource
@end

@interface FBComponentCollectionViewDataSource
    - (id) scrollEventHandler; // FBVideoHomeFeedViewController
@end

%hook FBStreamListCollectionView
    - (NSInteger) numberOfSections {
        NSInteger number = %orig;
        if (
            self.dataSource &&
            [self.dataSource isKindOfClass: %c(FBComponentCollectionViewDataSource)] &&
            ((FBComponentCollectionViewDataSource*) self.dataSource).scrollEventHandler &&
            [((FBComponentCollectionViewDataSource*) self.dataSource).scrollEventHandler isKindOfClass: %c(FBVideoHomeFeedViewController)] &&
            number > 2
        ) {
            number = 2;
        }
        return number;
    }
%end

// I know hooking non-subclassed view is generally considered a bad practise
// but in this case, there aren't really any non-extremely-complicated ways
// to accomplish this behavior, this shouldn't have a big impact
// on performance
%hook UICollectionView
    - (NSInteger) numberOfItemsInSection:(NSInteger)section {
        if (![self.superview isKindOfClass: %c(FBVideoChannelView)]) {
            return %orig;
        } else {
            return 1;
        }
    }
%end
