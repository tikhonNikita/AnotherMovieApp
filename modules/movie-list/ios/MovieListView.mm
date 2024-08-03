#import "MovieListView.h"
#import <react/renderer/components/RNMovieList/ComponentDescriptors.h>
#import <react/renderer/components/RNMovieList/EventEmitters.h>
#import <react/renderer/components/RNMovieList/Props.h>
#import <react/renderer/components/RNMovieList/RCTComponentViewHelpers.h>
#import "RCTFabricComponentsPlugins.h"
#import "React/RCTConversions.h"

using namespace facebook::react;


//TODO: refactor code - move helpers functionality to another class of file
//TODO: refactor favourites functionality - we have number/string conversion. Probbably - not needed
template <typename StatusType>
NetworkStatus convertToMovieModelStatus(StatusType status) {
    switch (status) {
        case StatusType::Loading:
            return [NetworkStatusHelper createLoading];
        case StatusType::Error:
            return [NetworkStatusHelper createError];
        case StatusType::Success:
            return [NetworkStatusHelper createSuccess];
    }
}

@interface MovieListView () <RCTMovieListViewViewProtocol>
@end

@implementation MovieListView {
    MovieListViewController * _movie_list_view_controller;
    UIView * _view;
}

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
    return concreteComponentDescriptorProvider<MovieListViewComponentDescriptor>();
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        static const auto defaultProps = std::make_shared<const MovieListViewProps>();
        _props = defaultProps;
        
        //TODO: move to updateProps
        __weak MovieListView *weakSelf = self;
        self->_movie_list_view_controller = [MovieListViewController createViewControllerOnMoviePress:^(NSString* movieId) {
            __strong MovieListView *strongSelf = weakSelf;
            if (strongSelf) {
                [strongSelf onMoviePress:movieId];
            }
        }];
        
        return self;
    }
    return nil;
}

-(void)didMoveToWindow {
    [super didMoveToWindow];
    if (self.window) {
        [self setupView];
    }
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
    const auto &oldViewProps = *std::static_pointer_cast<MovieListViewProps const>(_props);
    const auto &newViewProps = *std::static_pointer_cast<MovieListViewProps const>(props);
    
    if(oldViewProps.movieListStatus != newViewProps.movieListStatus) {
        NSLog(@"STATUS changed, MOVIE LIST changed");
        NetworkStatus status = convertToMovieModelStatus(newViewProps.movieListStatus);
        [_movie_list_view_controller updateMovieListStatusWithStatus:status];
        
        NSArray<Movie *> *newMoviesArray = [self convertToMoviesList:newViewProps.movies];
        [_movie_list_view_controller updateMoviesWithMovies:newMoviesArray];
    }
    
    if(oldViewProps.movieDetailsStatus != newViewProps.movieDetailsStatus) {
        NSLog(@"MOVIE DETAILS status changed");
        NetworkStatus status = convertToMovieModelStatus(newViewProps.movieDetailsStatus);
        [_movie_list_view_controller updateSelectedMovieDetailsStatusWithStatus:status];
    }
    
    const auto movieDetails = newViewProps.movieDetails;
    
    NSLog(@"MOVIE DETAILS data changed");
    const auto newMovieDetails = [self convertToMovieDetails:newViewProps.movieDetails];
    [_movie_list_view_controller updateSelectedMovieDetailsWithSelectedMovie:newMovieDetails];
    
    __weak MovieListView *weakSelf = self;
    [_movie_list_view_controller updateOnMovieAddedToFavoritesHandlerOnMoviePress:^(NSString* movieId) {
        __strong MovieListView *strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf onMovieAddedToFavourites:movieId];
        }
    }];
    
    [_movie_list_view_controller updateOnMovieRemovedFromFavoritesHandlerOnMoviePress:^(NSString* movieId) {
        __strong MovieListView *strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf onMovieRemovedFromFavorites:movieId];
        }
    }];
    
    
    [super updateProps:props oldProps:oldProps];
}

Class<RCTComponentViewProtocol> MovieListViewCls(void)
{
    return MovieListView.class;
}

- (UIViewController *)parentViewController {
    UIResponder *responder = self;
    NSLog(@"Parent view controller Initilally. Responder: %@", responder);
    while ([responder isKindOfClass:[UIView class]]) {
        responder = [responder nextResponder];
    }
    if ([responder isKindOfClass:[UIViewController class]]) {
        return (UIViewController *)responder;
    } else {
        NSLog(@"Parent view controller is nil. Responder: %@", responder);
        return nil;
    }
}

- (void)setupView {
    UIViewController *parentViewController = [self parentViewController];
    if (parentViewController) {
        UIView *swiftUIView = _movie_list_view_controller.view;
        [self addSubview:swiftUIView];
        swiftUIView.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint activateConstraints:@[
            [swiftUIView.topAnchor constraintEqualToAnchor:self.topAnchor],
            [swiftUIView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
            [swiftUIView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
            [swiftUIView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
        ]];
        
        [parentViewController addChildViewController:_movie_list_view_controller];
        [_movie_list_view_controller didMoveToParentViewController:parentViewController];
    }
}

- (NSArray<Movie *> *)convertToMoviesList:(const std::vector<MovieListViewMoviesStruct> &)moviesStruct {
    NSMutableArray<Movie *> *moviesArray = [NSMutableArray arrayWithCapacity:moviesStruct.size()];
    
    for (const auto &movieStruct : moviesStruct) {
        Movie *movie = [Movie createWithId:movieStruct.id
                                       url:[NSString stringWithUTF8String:movieStruct.url.c_str()]
                                     title:[NSString stringWithUTF8String:movieStruct.title.c_str()]
                          movieDescription:[NSString stringWithUTF8String:movieStruct.movieDescription.c_str()]
                                    rating:movieStruct.rating];
        [moviesArray addObject:movie];
    }
    
    return [moviesArray copy];
}


- (MovieDetails *)convertToMovieDetails:(const MovieListViewMovieDetailsStruct &)detailsStruct {
    NSMutableArray<Genre *> *genresArray = [NSMutableArray arrayWithCapacity:detailsStruct.genres.size()];
    
    for (const auto &genreStruct : detailsStruct.genres) {
        Genre *genre = [Genre createGenreWithId:genreStruct.id
                                           name:[NSString stringWithUTF8String:genreStruct.name.c_str()]];
        [genresArray addObject:genre];
    }
    
    MovieDetails *details = [MovieDetails createWithId:detailsStruct.id
                                             posterURL:[NSString stringWithUTF8String:detailsStruct.posterURL.c_str()]
                                                 title:[NSString stringWithUTF8String:detailsStruct.title.c_str()]
                                              overview:[NSString stringWithUTF8String:detailsStruct.overview.c_str()]
                                                rating: detailsStruct.rating
                                                genres:genresArray
                                           isFavourite: detailsStruct.isFavourite
    ];
    return details;
}

- (NetworkStatus)convertToMovieModelStatus:(MovieListViewMovieListStatus) status {
    return convertToMovieModelStatus<MovieListViewMovieListStatus>(status);
}

- (NetworkStatus)convertToMovieModelStatusFromDetails:(MovieListViewMovieDetailsStatus) status {
    return convertToMovieModelStatus<MovieListViewMovieDetailsStatus>(status);
}

- (void)onMoviePress:(NSString *)movieId {
    if (_eventEmitter != nullptr) {
        auto emitter = std::dynamic_pointer_cast<const facebook::react::MovieListViewEventEmitter>(_eventEmitter);
        if (emitter) {
            const char *cString = [movieId UTF8String];
            std::string cppString(cString);
            emitter->onMoviePress(facebook::react::MovieListViewEventEmitter::OnMoviePress{cppString});
        }
    }
}

- (void)onMovieAddedToFavourites:(NSString *)movieId {
    if (_eventEmitter != nullptr) {
        auto emitter = std::dynamic_pointer_cast<const facebook::react::MovieListViewEventEmitter>(_eventEmitter);
        if (emitter) {
            const char *cString = [movieId UTF8String];
            std::string cppString(cString);
            emitter->onMovieAddedToFavorites(facebook::react::MovieListViewEventEmitter::OnMovieAddedToFavorites{cppString});
        }
    }
}

- (void)onMovieRemovedFromFavorites:(NSString *)movieId {
    if (_eventEmitter != nullptr) {
        auto emitter = std::dynamic_pointer_cast<const facebook::react::MovieListViewEventEmitter>(_eventEmitter);
        if (emitter) {
            const char *cString = [movieId UTF8String];
            std::string cppString(cString);
            emitter->onMovieRemovedFromFavorites(facebook::react::MovieListViewEventEmitter::OnMovieRemovedFromFavorites{cppString});
        }
    }
}

@end
