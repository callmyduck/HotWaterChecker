///Protocol for files that were unzipped.
///They should have filename to let us locate them quickly and handy.
protocol PreviouslyUnzipped {
    static var previouslyUnzippedFileName: String { get }
}
